import 'dart:io';

/// Platform-specific utilities for permission handling.
class PlatformUtils {
  /// Returns true if running on iOS.
  static bool get isIOS => Platform.isIOS;

  /// Returns true if running on Android.
  static bool get isAndroid => Platform.isAndroid;

  /// Returns true if Android version requires runtime notification permission.
  /// Android 13+ (API 33) requires POST_NOTIFICATIONS permission.
  static bool get requiresNotificationPermission => Platform.isAndroid;

  /// Returns true if platform supports background location as separate permission.
  /// Android 10+ (API 29) requires separate background location permission.
  static bool get hasBackgroundLocationPermission => Platform.isAndroid;

  /// Returns true if platform supports precise vs approximate location.
  /// iOS 14+ introduced this distinction.
  static bool get supportsPreciseLocation => Platform.isIOS;
}
