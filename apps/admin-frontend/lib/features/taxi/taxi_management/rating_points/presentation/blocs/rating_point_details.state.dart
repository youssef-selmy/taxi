part of 'rating_point_details.cubit.dart';

@freezed
sealed class RatingPointDetailsState with _$RatingPointDetailsState {
  const factory RatingPointDetailsState({
    String? name,
    bool? isPositive,
    required ApiResponse<Fragment$reviewTaxiParameterListItem?> ratingPoint,
    required ApiResponse<void> networkStateSave,
  }) = _RatingPointDetailsState;

  factory RatingPointDetailsState.initial() => RatingPointDetailsState(
    ratingPoint: const ApiResponse.initial(),
    networkStateSave: const ApiResponse.initial(),
  );
}
