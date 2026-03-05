part of 'reviews_shop.cubit.dart';

@freezed
sealed class ReviewsShopState with _$ReviewsShopState {
  const factory ReviewsShopState({
    String? customerId,
    required ApiResponse<Query$customerShopReviews> networkState,
    Input$OffsetPaging? paging,
  }) = _ReviewsShopState;
}
