import 'permission_status.dart';
import 'permission_type.dart';

/// Result of a permission request operation.
sealed class PermissionRequestResult {
  const PermissionRequestResult();

  /// Returns true if permission was granted.
  bool get isGranted => this is PermissionRequestResultGranted;

  /// Returns true if user should be directed to settings.
  bool get shouldOpenSettings => this is PermissionRequestResultPermanentlyDenied;
}

/// Permission was granted successfully.
class PermissionRequestResultGranted extends PermissionRequestResult {
  final PermissionType type;
  final PermissionStatus status;

  const PermissionRequestResultGranted({
    required this.type,
    required this.status,
  });
}

/// Permission was denied by the user.
class PermissionRequestResultDenied extends PermissionRequestResult {
  final PermissionType type;
  final PermissionStatus status;

  const PermissionRequestResultDenied({
    required this.type,
    required this.status,
  });
}

/// Permission is permanently denied - user must go to settings.
class PermissionRequestResultPermanentlyDenied extends PermissionRequestResult {
  final PermissionType type;

  const PermissionRequestResultPermanentlyDenied({
    required this.type,
  });
}

/// User dismissed the rationale dialog without taking action.
class PermissionRequestResultDismissed extends PermissionRequestResult {
  final PermissionType type;

  const PermissionRequestResultDismissed({
    required this.type,
  });
}

/// GPS/Location services are disabled at system level.
class PermissionRequestResultServiceDisabled extends PermissionRequestResult {
  final PermissionType type;

  const PermissionRequestResultServiceDisabled({
    required this.type,
  });
}
