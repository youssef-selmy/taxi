part of 'shop_support_request_list.cubit.dart';

@freezed
sealed class ShopSupportRequestState with _$ShopSupportRequestState {
  const factory ShopSupportRequestState({
    required ApiResponse<Query$shopSupportRequests> supportRequest,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ShopSupportRequestSort> sortFields,
    @Default([]) List<Enum$ComplaintStatus> filterStatus,
  }) = _ShopSupportRequestState;

  factory ShopSupportRequestState.initial() =>
      ShopSupportRequestState(supportRequest: const ApiResponse.initial());
}
