part of 'fleet_list.cubit.dart';

@freezed
sealed class FleetListState with _$FleetListState {
  const factory FleetListState({
    required ApiResponse<Query$fleetsList> fleets,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$FleetSort> sortFields,
  }) = _FleetState;

  factory FleetListState.initial() =>
      FleetListState(fleets: const ApiResponse.initial());
}
