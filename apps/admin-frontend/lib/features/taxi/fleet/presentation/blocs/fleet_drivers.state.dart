part of 'fleet_drivers.cubit.dart';

@freezed
sealed class FleetDriversState with _$FleetDriversState {
  const factory FleetDriversState({
    required ApiResponse<Query$fleetDrivers> fleetDrivers,
    String? fleetId,
    String? search,
    Input$DriverFilter? filterDriver,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$DriverSort> sortFields,
    @Default([]) List<Enum$DriverStatus> driverStatusFilter,
  }) = _FleetDriversState;

  factory FleetDriversState.initial() =>
      FleetDriversState(fleetDrivers: const ApiResponse.initial());
}
