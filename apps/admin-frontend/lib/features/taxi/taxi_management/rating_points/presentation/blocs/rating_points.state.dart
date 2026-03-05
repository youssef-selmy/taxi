part of 'rating_points.cubit.dart';

@freezed
sealed class RatingPointsState with _$RatingPointsState {
  const factory RatingPointsState({
    required ApiResponse<List<Fragment$reviewTaxiParameterListItem>>
    ratingPoints,
  }) = _RatingPointsState;

  factory RatingPointsState.initial() =>
      RatingPointsState(ratingPoints: const ApiResponse.initial());

  const RatingPointsState._();

  ApiResponse<List<Fragment$reviewTaxiParameterListItem>>
  get positiveRatingPoints => switch (ratingPoints) {
    ApiResponseLoaded(:final data) => ApiResponse.loaded(data.positivePoints),
    _ => ratingPoints,
  };

  ApiResponse<List<Fragment$reviewTaxiParameterListItem>>
  get negativeRatingPoints => switch (ratingPoints) {
    ApiResponseLoaded(:final data) => ApiResponse.loaded(data.negativePoints),
    _ => ratingPoints,
  };
}
