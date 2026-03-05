part of 'parking_order_detail_reviews.cubit.dart';

@freezed
sealed class ParkingOrderDetailReviewsState
    with _$ParkingOrderDetailReviewsState {
  const factory ParkingOrderDetailReviewsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$getParkingOrderReview> parkingOrderReviewState,
  }) = _ParkingOrderDetailReviewsState;
}
