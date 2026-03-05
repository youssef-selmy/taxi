part of 'shop_order_detail_reviews.cubit.dart';

@freezed
sealed class ShopOrderDetailReviewsState with _$ShopOrderDetailReviewsState {
  const factory ShopOrderDetailReviewsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopOrderReviews> shopOrderDetailReviewsState,
  }) = _ShopOrderDetailReviewsState;
}
