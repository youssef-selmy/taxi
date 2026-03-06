/// Unified permission status across iOS and Android.
enum PermissionStatus {
  /// Permission has been granted.
  granted,

  /// iOS only: User granted approximate location instead of precise.
  limited,

  /// Location permission granted only while app is in use.
  whileInUse,

  /// Location permission granted for background access ("always").
  always,

  /// Permission was denied but can be requested again.
  denied,

  /// Permission was permanently denied - user must enable in settings.
  permanentlyDenied,

  /// iOS only: Permission is restricted by parental controls or MDM.
  restricted,
}

/// Extension to check permission status properties.
extension PermissionStatusX on PermissionStatus {
  /// Returns true if permission is granted (including limited access).
  bool get isGranted => switch (this) {
        PermissionStatus.granted ||
        PermissionStatus.limited ||
        PermissionStatus.whileInUse ||
        PermissionStatus.always =>
          true,
        _ => false,
      };

  /// Returns true if permission is denied and can still be requested.
  bool get canRequest => this == PermissionStatus.denied;

  /// Returns true if user must go to settings to grant permission.
  bool get requiresSettings => switch (this) {
        PermissionStatus.permanentlyDenied || PermissionStatus.restricted => true,
        _ => false,
      };

  /// Returns true if location access is for background use.
  bool get hasBackgroundAccess => this == PermissionStatus.always;
}
