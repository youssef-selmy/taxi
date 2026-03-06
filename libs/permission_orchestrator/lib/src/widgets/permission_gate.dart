import 'package:flutter/material.dart';

import '../models/permission_request_result.dart';
import '../models/permission_status.dart';
import '../models/permission_type.dart';
import '../service/permission_service.dart';
import 'permission_rationale_dialog.dart';
import 'permission_settings_dialog.dart';

/// Configuration for permission rationale content.
class PermissionRationale {
  /// Title shown in the rationale dialog.
  final String title;

  /// Description explaining why the permission is needed.
  final String description;

  /// Icon shown in the rationale dialog.
  final IconData icon;

  /// Text for the primary action button.
  final String primaryButtonText;

  /// Text for the secondary/cancel button.
  final String secondaryButtonText;

  const PermissionRationale({
    required this.title,
    required this.description,
    this.icon = Icons.info_outline,
    this.primaryButtonText = 'Allow',
    this.secondaryButtonText = 'Not now',
  });

  /// Default rationale for location permission.
  static const location = PermissionRationale(
    title: 'Location Access Required',
    description: 'We need access to your location to provide accurate pickup points and navigation.',
    icon: Icons.location_on,
    primaryButtonText: 'Enable Location',
  );

  /// Default rationale for background location permission.
  static const backgroundLocation = PermissionRationale(
    title: 'Background Location Required',
    description: 'To track your trip and provide accurate updates, we need location access even when the app is in the background.',
    icon: Icons.location_on,
    primaryButtonText: 'Enable Background Location',
  );

  /// Default rationale for notification permission.
  static const notification = PermissionRationale(
    title: 'Enable Notifications',
    description: 'Stay updated with ride requests, trip status, and important updates. You can customize notifications in settings later.',
    icon: Icons.notifications_active,
    primaryButtonText: 'Enable Notifications',
  );
}

/// Configuration for settings redirect content.
class SettingsRedirectConfig {
  /// Title shown when redirecting to settings.
  final String title;

  /// Description explaining how to enable in settings.
  final String description;

  /// Text for the open settings button.
  final String openSettingsText;

  /// Text for the cancel button.
  final String cancelText;

  const SettingsRedirectConfig({
    required this.title,
    required this.description,
    this.openSettingsText = 'Open Settings',
    this.cancelText = 'Cancel',
  });

  /// Default config for location settings.
  static const location = SettingsRedirectConfig(
    title: 'Location Permission Denied',
    description: 'Location permission was denied. Please enable it in your device settings to continue.',
  );

  /// Default config for notification settings.
  static const notification = SettingsRedirectConfig(
    title: 'Notifications Disabled',
    description: 'Notifications are disabled. Enable them in your device settings to receive important updates about your rides.',
  );
}

/// A widget that gates access based on permission status.
///
/// Shows rationale dialog before requesting permission, and redirects to
/// settings when permission is permanently denied.
///
/// Example:
/// ```dart
/// PermissionGate(
///   permissionService: locator<PermissionService>(),
///   permission: PermissionType.locationAlways,
///   required: true,
///   rationale: PermissionRationale.backgroundLocation,
///   settingsConfig: SettingsRedirectConfig.location,
///   onGranted: () => startLocationTracking(),
///   child: GoOnlineButton(),
///   fallback: LocationDisabledNotice(),
/// )
/// ```
class PermissionGate extends StatefulWidget {
  /// The permission service to use.
  final PermissionService permissionService;

  /// The type of permission to request.
  final PermissionType permission;

  /// If true, blocks child until permission is granted.
  /// If false, shows fallback widget when denied (soft gate).
  final bool required;

  /// Configuration for the rationale dialog.
  final PermissionRationale rationale;

  /// Configuration for settings redirect dialog.
  final SettingsRedirectConfig settingsConfig;

  /// Called when permission is granted.
  final VoidCallback? onGranted;

  /// Called when permission is denied (soft gate only).
  final VoidCallback? onDenied;

  /// The child widget to show when permission is granted.
  final Widget child;

  /// Widget to show when permission is denied (soft gate only).
  final Widget? fallback;

  /// If true, checks permission status on init and shows dialog if needed.
  /// If false, only checks when [check] is called.
  final bool checkOnInit;

  const PermissionGate({
    super.key,
    required this.permissionService,
    required this.permission,
    required this.rationale,
    required this.settingsConfig,
    required this.child,
    this.required = false,
    this.onGranted,
    this.onDenied,
    this.fallback,
    this.checkOnInit = false,
  });

  @override
  State<PermissionGate> createState() => PermissionGateState();
}

class PermissionGateState extends State<PermissionGate> {
  PermissionStatus? _status;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    if (widget.checkOnInit) {
      _checkPermission(showDialogs: false);
    }
  }

  /// Check permission and request if needed.
  ///
  /// Call this method to trigger the permission flow with dialogs.
  /// Returns true if permission was granted.
  Future<bool> check() async {
    return _checkPermission(showDialogs: true);
  }

  Future<bool> _checkPermission({required bool showDialogs}) async {
    if (_isChecking) return false;

    setState(() => _isChecking = true);

    try {
      // Check current status
      final status = await widget.permissionService.checkPermission(widget.permission);
      setState(() => _status = status);

      // If granted, we're done
      if (status.isGranted) {
        widget.onGranted?.call();
        return true;
      }

      if (!showDialogs || !mounted) {
        widget.onDenied?.call();
        return false;
      }

      // Check if we should show rationale (cooldown not active)
      final canShowRationale = await widget.permissionService.canShowRationale(widget.permission);

      // If permanently denied, show settings dialog
      if (status.requiresSettings) {
        if (canShowRationale) {
          final openedSettings = await _showSettingsDialog();
          if (openedSettings) {
            // User went to settings, they'll come back later
            return false;
          }
        }
        widget.onDenied?.call();
        return false;
      }

      // If can request, show rationale first then request
      if (status.canRequest && canShowRationale) {
        final shouldRequest = await _showRationaleDialog();
        if (!shouldRequest) {
          await widget.permissionService.recordDismissal(widget.permission);
          widget.onDenied?.call();
          return false;
        }

        // Request permission
        final result = await widget.permissionService.requestPermission(widget.permission);
        final newStatus = switch (result) {
          PermissionRequestResultGranted(:final status) => status,
          PermissionRequestResultDenied(:final status) => status,
          PermissionRequestResultPermanentlyDenied() => PermissionStatus.permanentlyDenied,
          PermissionRequestResultDismissed() => PermissionStatus.denied,
          PermissionRequestResultServiceDisabled() => PermissionStatus.denied,
        };

        setState(() => _status = newStatus);

        if (result.isGranted) {
          widget.onGranted?.call();
          return true;
        }

        // If permanently denied after request, show settings dialog
        if (result.shouldOpenSettings) {
          await _showSettingsDialog();
        }

        widget.onDenied?.call();
        return false;
      }

      widget.onDenied?.call();
      return false;
    } finally {
      if (mounted) {
        setState(() => _isChecking = false);
      }
    }
  }

  Future<bool> _showRationaleDialog() async {
    if (!mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PermissionRationaleDialog(
        title: widget.rationale.title,
        description: widget.rationale.description,
        icon: widget.rationale.icon,
        primaryButtonText: widget.rationale.primaryButtonText,
        secondaryButtonText: widget.rationale.secondaryButtonText,
      ),
    );

    return result ?? false;
  }

  Future<bool> _showSettingsDialog() async {
    if (!mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PermissionSettingsDialog(
        title: widget.settingsConfig.title,
        description: widget.settingsConfig.description,
        openSettingsText: widget.settingsConfig.openSettingsText,
        cancelText: widget.settingsConfig.cancelText,
        onOpenSettings: () async {
          // Open appropriate settings based on permission type
          if (widget.permission == PermissionType.locationWhenInUse ||
              widget.permission == PermissionType.locationAlways) {
            return widget.permissionService.openAppSettings();
          }
          return widget.permissionService.openAppSettings();
        },
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Soft gate: show fallback when denied
    if (!widget.required && _status != null && !_status!.isGranted) {
      return widget.fallback ?? widget.child;
    }

    return widget.child;
  }
}
