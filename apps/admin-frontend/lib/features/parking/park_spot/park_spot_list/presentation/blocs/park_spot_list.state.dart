part of 'park_spot_list.cubit.dart';

@freezed
sealed class ParkSpotListState with _$ParkSpotListState {
  const factory ParkSpotListState({
    @Default(ApiResponseInitial()) ApiResponse<Query$parkSpots> parkSpotsState,
    @Default(Enum$ParkSpotType.PUBLIC) Enum$ParkSpotType parkSpotType,
    String? searchQuery,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ParkSpotSort> sorting,
    @Default([]) List<Enum$ParkSpotStatus> statusFilter,
  }) = _ParkSpotListState;
}
