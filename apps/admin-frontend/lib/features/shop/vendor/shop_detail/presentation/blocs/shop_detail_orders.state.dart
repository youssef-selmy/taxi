part of 'shop_detail_orders.cubit.dart';

@freezed
sealed class ShopDetailOrdersState with _$ShopDetailOrdersState {
  const factory ShopDetailOrdersState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopOrders> ordersHistoryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopActiveOrders> activeOrdersState,
    String? shopId,
    @Default(0) int selectedTab,
    Input$OffsetPaging? historyPaging,
    @Default([]) List<Input$ShopOrderSort> sorting,
    @Default([]) List<Enum$ShopOrderStatus> statusFilter,
  }) = _ShopDetailOrdersState;

  const ShopDetailOrdersState._();

  List<Fragment$shopOrderListItem> get onHoldOrders =>
      _filterActiveOrdersByStatus(Enum$ShopOrderStatus.OnHold);

  List<Fragment$shopOrderListItem> get openOrders =>
      _filterActiveOrdersByStatus(Enum$ShopOrderStatus.New);

  List<Fragment$shopOrderListItem> get outForDeliveryOrders =>
      _filterActiveOrdersByStatus(Enum$ShopOrderStatus.OutForDelivery);

  List<Fragment$shopOrderListItem> get processingOrders =>
      _filterActiveOrdersByStatus(Enum$ShopOrderStatus.Processing);

  List<Fragment$shopOrderListItem> _filterActiveOrdersByStatus(
    Enum$ShopOrderStatus status,
  ) =>
      activeOrdersState.data?.shopOrders.nodes
          .where((order) => status == order.status)
          .toList() ??
      [];
}
