part of 'orders_shop.cubit.dart';

@freezed
sealed class OrdersShopState with _$OrdersShopState {
  const factory OrdersShopState({
    String? customerId,
    Input$OffsetPaging? paging,
    @Default([]) List<Enum$ShopOrderStatus> statuses,
    @Default([]) List<Enum$PaymentMode> paymentModes,
    @Default([]) List<Input$ShopOrderSort> sorting,
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerOrdersShop> ordersState,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _OrdersShopState;

  const OrdersShopState._();

  Input$ShopOrderFilter get filter => Input$ShopOrderFilter(
    status: statuses.isEmpty
        ? null
        : Input$ShopOrderStatusFilterComparison($in: statuses),
    paymentMethod: paymentModes.isEmpty
        ? null
        : Input$PaymentModeFilterComparison($in: paymentModes),
  );
}
