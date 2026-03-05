part of 'shop_detail_order_detail_dialog.bloc.dart';

@freezed
sealed class ShopDetailOrderDetailDialogState
    with _$ShopDetailOrderDetailDialogState {
  const factory ShopDetailOrderDetailDialogState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$orderShopDetail> orderState,
    String? orderId,
  }) = _ShopDetailOrderDetailDialogState;
}
