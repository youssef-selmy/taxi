part of 'shop_order_detail_complaints.cubit.dart';

@freezed
sealed class ShopOrderDetailComplaintsState
    with _$ShopOrderDetailComplaintsState {
  const factory ShopOrderDetailComplaintsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$getShopOrderComplaints> shopOrderComplaintsState,
  }) = _ShopOrderDetailComplaintsState;
}
