part of 'shop_order_detail.cubit.dart';

@freezed
sealed class ShopOrderDetailState with _$ShopOrderDetailState {
  const factory ShopOrderDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$orderShopDetail> shopOrderDetailState,
  }) = _ShopOrderDetailState;

  const ShopOrderDetailState._();

  int get itemsCount =>
      shopOrderDetailState.data?.carts.fold(
        0,
        (previousValue, element) =>
            (previousValue ?? 0) + (element.products.length),
      ) ??
      0;
}
