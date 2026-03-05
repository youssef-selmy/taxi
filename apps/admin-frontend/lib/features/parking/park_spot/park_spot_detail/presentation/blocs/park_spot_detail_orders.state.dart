part of 'park_spot_detail_orders.cubit.dart';

@freezed
sealed class ParkSpotDetailOrdersState with _$ParkSpotDetailOrdersState {
  const factory ParkSpotDetailOrdersState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkSpotOrders> ordersHistoryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkSpotActiveOrders> activeOrdersState,
    String? parkSpotId,
    @Default(0) int selectedTab,
    Input$OffsetPaging? historyPaging,
    @Default([]) List<Input$ParkOrderSort> sorting,
    @Default([]) List<Enum$ParkOrderStatus> statusFilter,
  }) = _ParkSpotDetailOrdersState;

  const ParkSpotDetailOrdersState._();

  List<Fragment$parkingOrderListItem> get pendingOrders =>
      activeOrdersState.data?.parkOrders.nodes
          .where((order) => order.status == Enum$ParkOrderStatus.PENDING)
          .toList() ??
      [];

  List<Fragment$parkingOrderListItem> get paidOrders =>
      activeOrdersState.data?.parkOrders.nodes
          .where((order) => order.status == Enum$ParkOrderStatus.PAID)
          .toList() ??
      [];

  List<Fragment$parkingOrderListItem> get acceptedOrders =>
      activeOrdersState.data?.parkOrders.nodes
          .where((order) => order.status == Enum$ParkOrderStatus.ACCEPTED)
          .toList() ??
      [];
}
