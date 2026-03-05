part of 'staff_role_details.cubit.dart';

@freezed
sealed class StaffRoleDetailsState with _$StaffRoleDetailsState {
  const factory StaffRoleDetailsState({
    String? staffRoleId,
    @Default(ApiResponseInitial()) ApiResponse<Fragment$staffRole?> staffRole,
    @Default(ApiResponseInitial()) ApiResponse<void> networkStateSave,
    String? title,
    @Default([]) List<Enum$AppType> allowedAppTypes,
    @Default([]) List<Enum$OperatorPermission> permissions,
    @Default([]) List<Enum$TaxiPermission> taxiPermissions,
    @Default([]) List<Enum$ShopPermission> shopPermissions,
    @Default([]) List<Enum$ParkingPermission> parkingPermissions,
  }) = _StaffRoleDetailsState;

  const StaffRoleDetailsState._();

  Input$OperatorRoleInput toInput() {
    return Input$OperatorRoleInput(
      title: title!,
      allowedApps: allowedAppTypes,
      permissions: permissions,
      taxiPermissions: taxiPermissions,
      shopPermissions: shopPermissions,
      parkingPermissions: parkingPermissions,
    );
  }
}
