import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dismissal_record.dart';
import '../models/permission_request_result.dart';
import '../models/permission_status.dart';
import '../models/permission_type.dart';
import 'permission_service.dart';

/// Implementation of [PermissionService] using permission_handler, geolocator,
/// and firebase_messaging packages.
class PermissionServiceImpl implements PermissionService {
  final SharedPreferences _prefs;
  final StreamController<(PermissionType, PermissionStatus)> _permissionChangesController;

  static const _dismissalKey = 'permission_dismissals';
  static const _cooldownDuration = Duration(hours: 24);

  PermissionServiceImpl({
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        _permissionChangesController = StreamController.broadcast();

  @override
  Future<PermissionStatus> checkPermission(PermissionType type) async {
    return switch (type) {
      PermissionType.locationWhenInUse => _checkLocationPermission(background: false),
      PermissionType.locationAlways => _checkLocationPermission(background: true),
      PermissionType.notification => _checkNotificationPermission(),
    };
  }

  Future<PermissionStatus> _checkLocationPermission({required bool background}) async {
    final permission = await Geolocator.checkPermission();
    return _mapLocationPermission(permission, requiresAlways: background);
  }

  Future<PermissionStatus> _checkNotificationPermission() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    return _mapNotificationStatus(settings.authorizationStatus);
  }

  PermissionStatus _mapLocationPermission(
    LocationPermission permission, {
    required bool requiresAlways,
  }) {
    return switch (permission) {
      LocationPermission.denied => PermissionStatus.denied,
      LocationPermission.deniedForever => PermissionStatus.permanentlyDenied,
      LocationPermission.whileInUse =>
        requiresAlways ? PermissionStatus.whileInUse : PermissionStatus.granted,
      LocationPermission.always => PermissionStatus.always,
      LocationPermission.unableToDetermine => PermissionStatus.denied,
    };
  }

  PermissionStatus _mapNotificationStatus(AuthorizationStatus status) {
    return switch (status) {
      AuthorizationStatus.authorized => PermissionStatus.granted,
      AuthorizationStatus.provisional => PermissionStatus.granted,
      AuthorizationStatus.denied => PermissionStatus.permanentlyDenied,
      AuthorizationStatus.notDetermined => PermissionStatus.denied,
    };
  }

  @override
  Future<PermissionRequestResult> requestPermission(PermissionType type) async {
    return switch (type) {
      PermissionType.locationWhenInUse => _requestLocationPermission(background: false),
      PermissionType.locationAlways => _requestLocationPermission(background: true),
      PermissionType.notification => _requestNotificationPermission(),
    };
  }

  Future<PermissionRequestResult> _requestLocationPermission({
    required bool background,
  }) async {
    // First check if location services are enabled
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return PermissionRequestResultServiceDisabled(
        type: background ? PermissionType.locationAlways : PermissionType.locationWhenInUse,
      );
    }

    // Check current status
    var permission = await Geolocator.checkPermission();

    // If denied, request permission
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    final type = background ? PermissionType.locationAlways : PermissionType.locationWhenInUse;

    // Handle denied forever
    if (permission == LocationPermission.deniedForever) {
      return PermissionRequestResultPermanentlyDenied(type: type);
    }

    // If we need background and only have foreground, request background
    if (background &&
        permission == LocationPermission.whileInUse &&
        Platform.isAndroid) {
      // On Android, request background location separately
      final bgStatus = await ph.Permission.locationAlways.request();
      if (bgStatus.isPermanentlyDenied) {
        return PermissionRequestResultPermanentlyDenied(type: type);
      }
      if (bgStatus.isDenied) {
        return PermissionRequestResultDenied(
          type: type,
          status: PermissionStatus.whileInUse,
        );
      }
      // Re-check after background request
      permission = await Geolocator.checkPermission();
    }

    final status = _mapLocationPermission(permission, requiresAlways: background);
    _permissionChangesController.add((type, status));

    if (status.isGranted || (background && status == PermissionStatus.always)) {
      return PermissionRequestResultGranted(type: type, status: status);
    }

    return PermissionRequestResultDenied(type: type, status: status);
  }

  Future<PermissionRequestResult> _requestNotificationPermission() async {
    final messaging = FirebaseMessaging.instance;

    // Check current status first
    final currentSettings = await messaging.getNotificationSettings();
    if (currentSettings.authorizationStatus == AuthorizationStatus.denied) {
      // On iOS, if already denied, we can't request again - must go to settings
      // On Android 13+, same behavior
      return const PermissionRequestResultPermanentlyDenied(
        type: PermissionType.notification,
      );
    }

    // Request permission
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final status = _mapNotificationStatus(settings.authorizationStatus);
    _permissionChangesController.add((PermissionType.notification, status));

    return switch (settings.authorizationStatus) {
      AuthorizationStatus.authorized ||
      AuthorizationStatus.provisional =>
        PermissionRequestResultGranted(
          type: PermissionType.notification,
          status: status,
        ),
      AuthorizationStatus.denied => const PermissionRequestResultPermanentlyDenied(
          type: PermissionType.notification,
        ),
      AuthorizationStatus.notDetermined => PermissionRequestResultDenied(
          type: PermissionType.notification,
          status: status,
        ),
    };
  }

  @override
  Future<bool> openAppSettings() async {
    return ph.openAppSettings();
  }

  @override
  Future<bool> openLocationSettings() async {
    return Geolocator.openLocationSettings();
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> isPreciseLocationEnabled() async {
    if (!Platform.isIOS) {
      return true; // Android always has precise location when granted
    }

    final accuracy = await Geolocator.getLocationAccuracy();
    return accuracy == LocationAccuracyStatus.precise;
  }

  @override
  Stream<(PermissionType, PermissionStatus)> get permissionChanges =>
      _permissionChangesController.stream;

  @override
  Future<void> recordDismissal(PermissionType type) async {
    final dismissals = await _getDismissals();
    dismissals[type.name] = DismissalRecord(
      type: type,
      dismissedAt: DateTime.now(),
    ).toJson();
    await _prefs.setString(_dismissalKey, jsonEncode(dismissals));
  }

  @override
  Future<bool> canShowRationale(PermissionType type) async {
    final dismissals = await _getDismissals();
    final recordJson = dismissals[type.name];
    if (recordJson == null) {
      return true; // Never dismissed
    }

    final record = DismissalRecord.fromJson(recordJson as Map<String, dynamic>);
    return record.canShowAgain(cooldown: _cooldownDuration);
  }

  Future<Map<String, dynamic>> _getDismissals() async {
    final json = _prefs.getString(_dismissalKey);
    if (json == null) {
      return {};
    }
    return jsonDecode(json) as Map<String, dynamic>;
  }

  @override
  void dispose() {
    _permissionChangesController.close();
  }
}
