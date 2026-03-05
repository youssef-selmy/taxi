part of 'region_insights.cubit.dart';

@freezed
sealed class RegionInsightsState with _$RegionInsightsState {
  const factory RegionInsightsState({
    required ApiResponse<List<Fragment$nameCount>> regionPopularityChart,
  }) = _RegionInsightsState;
}
