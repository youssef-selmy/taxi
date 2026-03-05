part of 'taxi_order_detail_reviews.cubit.dart';

@freezed
sealed class TaxiOorderDetailReviewsState with _$TaxiOorderDetailReviewsState {
  const factory TaxiOorderDetailReviewsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$taxiOrderDetailReviews> taxiOrderReviewsState,
  }) = _ReviewsState;
}
