part of 'park_spot_list_statistics.cubit.dart';

@freezed
sealed class ParkSpotListStatisticsState with _$ParkSpotListStatisticsState {
  const factory ParkSpotListStatisticsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parSpotsStatistics> parkSpotsStatisticsState,
  }) = _ParkSpotListStatisticsState;
}
