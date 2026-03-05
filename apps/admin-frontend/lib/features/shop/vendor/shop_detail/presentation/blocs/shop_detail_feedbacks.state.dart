part of 'shop_detail_feedbacks.cubit.dart';

@freezed
sealed class ShopDetailFeedbacksState with _$ShopDetailFeedbacksState {
  const factory ShopDetailFeedbacksState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopFeedbacks> shopFeedbacksState,
    String? shopId,
  }) = _ShopDetailFeedbacksState;
}
