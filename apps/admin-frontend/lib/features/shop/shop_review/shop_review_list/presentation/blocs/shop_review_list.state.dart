part of 'shop_review_list.cubit.dart';

@freezed
sealed class ShopReviewListState with _$ShopReviewListState {
  const factory ShopReviewListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopFeedbacks> shopReviewsState,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ShopFeedbackSort> sortFields,
    @Default([]) List<Enum$ReviewStatus> filterStatus,
    String? search,
  }) = _ShopReviewListState;
}
