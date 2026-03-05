part of 'fleet_staff_detail.cubit.dart';

@freezed
sealed class FleetStaffDetailState with _$FleetStaffDetailState {
  const factory FleetStaffDetailState({
    @Default(ApiResponse.initial())
    ApiResponse<Fragment$fleetStaffs> fleetStaffUpdate,
    @Default(ApiResponse.initial())
    ApiResponse<Fragment$fleetStaffs> fleetStaff,
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? phoneNumber,
    String? mobileNumber,
    String? email,
    Enum$FleetStaffPermissionOrder? permissionOrder,
    Enum$FleetStaffPermissionFinancial? permissionFinancial,
    @Default(ApiResponse.initial()) ApiResponse<void> fleetStaffDelete,
  }) = _FleetStaffDetailState;
}
