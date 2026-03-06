/// Types of permissions that can be requested by the app.
enum PermissionType {
  /// Location permission (foreground only - "while in use")
  locationWhenInUse,

  /// Location permission (background - "always")
  locationAlways,

  /// Push notification permission
  notification,
}
