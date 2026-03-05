part of 'shop_support_request_detail.cubit.dart';

@freezed
sealed class ShopSupportRequestDetailState
    with _$ShopSupportRequestDetailState {
  const factory ShopSupportRequestDetailState({
    required ApiResponse<Query$shopSupportRequest> supportRequestState,
    String? comment,
    String? id,
    List<String>? staffsId,
    @Default(ApiResponse.initial())
    ApiResponse<void> createShopSupportRequestCommentState,
  }) = _ShopSupportRequestDetailState;

  factory ShopSupportRequestDetailState.initial() =>
      ShopSupportRequestDetailState(
        supportRequestState: const ApiResponse.initial(),
      );
}
