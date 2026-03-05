part of 'fleet_staffs.cubit.dart';

@freezed
sealed class FleetStaffsState with _$FleetStaffsState {
  const factory FleetStaffsState({
    required ApiResponse<Query$fleetStaffList> fleetStaffs,
    String? searchQuery,
    String? fleetId,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$FleetStaffSort> sortFields,
    @Default([]) List<bool> statusFilter,
  }) = _FleetStaffsState;

  factory FleetStaffsState.initial() =>
      FleetStaffsState(fleetStaffs: const ApiResponse.initial());
}
