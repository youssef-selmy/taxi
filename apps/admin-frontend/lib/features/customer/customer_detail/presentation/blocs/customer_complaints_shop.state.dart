part of 'customer_complaints_shop.cubit.dart';

@freezed
sealed class CustomerComplaintsShopState with _$CustomerComplaintsShopState {
  const factory CustomerComplaintsShopState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerComplaintsShop> complaintsResponse,
    String? customerId,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ShopSupportRequestSort> sorting,
    @Default([]) List<Enum$ComplaintStatus> filterStatus,
  }) = _CustomerComplaintsShopState;
}
