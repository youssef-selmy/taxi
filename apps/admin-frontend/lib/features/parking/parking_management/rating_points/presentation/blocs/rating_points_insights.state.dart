part of 'rating_points_insights.cubit.dart';

@freezed
sealed class RatingPointsInsightsState with _$RatingPointsInsightsState {
  const factory RatingPointsInsightsState({
    required ApiResponse<List<Fragment$nameCount>> ratingPointInsights,
  }) = _RatingPointsInsightsState;
}
