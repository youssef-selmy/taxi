import 'dart:async';

import '../models/permission_status.dart';
import '../models/permission_type.dart';
import '../models/permission_request_result.dart';

/// Central service for managing app permissions.
///
/// Provides unified API for checking and requesting permissions across
/// iOS and Android, with support for:
/// - Location (foreground and background)
/// - Notifications
/// - GPS/Location service status
/// - iOS precise location
abstract class PermissionService {
  /// Check current status of a permission without requesting it.
  Future<PermissionStatus> checkPermission(PermissionType type);

  /// Request a permission from the user.
  ///
  /// Returns [PermissionRequestResult] indicating success or failure reason.
  Future<PermissionRequestResult> requestPermission(PermissionType type);

  /// Open system settings for the app.
  ///
  /// Use when permission is permanently denied and user needs to enable
  /// it manually in settings.
  Future<bool> openAppSettings();

  /// Open location settings (GPS toggle).
  ///
  /// Use when location services are disabled at system level.
  Future<bool> openLocationSettings();

  /// Check if GPS/Location services are enabled at system level.
  Future<bool> isLocationServiceEnabled();

  /// iOS only: Check if precise location is enabled.
  ///
  /// Returns true on Android (always precise).
  Future<bool> isPreciseLocationEnabled();

  /// Stream of permission status changes.
  ///
  /// Emits new status when permission changes (e.g., after app resume).
  Stream<(PermissionType, PermissionStatus)> get permissionChanges;

  /// Record that user dismissed the rationale dialog.
  Future<void> recordDismissal(PermissionType type);

  /// Check if rationale dialog can be shown (cooldown passed).
  Future<bool> canShowRationale(PermissionType type);

  /// Dispose resources.
  void dispose();
}
