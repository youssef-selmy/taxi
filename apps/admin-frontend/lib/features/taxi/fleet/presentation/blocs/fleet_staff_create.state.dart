part of 'fleet_staff_create.cubit.dart';

@freezed
sealed class FleetStaffCreateState with _$FleetStaffCreateState {
  const factory FleetStaffCreateState({
    required ApiResponse<Fragment$fleetStaffs> fleetStaffCreate,
    String? fleetId,
    String? firstName,
    String? lastName,
    String? userName,
    String? password,
    String? phoneNumber,
    String? email,
    Enum$FleetStaffPermissionOrder? permissionOrder,
    Enum$FleetStaffPermissionFinancial? permissionFinancial,
  }) = _FleetStaffCreateState;

  factory FleetStaffCreateState.initial() =>
      FleetStaffCreateState(fleetStaffCreate: const ApiResponse.initial());
}
