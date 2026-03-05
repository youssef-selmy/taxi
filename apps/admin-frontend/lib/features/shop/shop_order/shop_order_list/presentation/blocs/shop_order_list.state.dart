part of 'shop_order_list.cubit.dart';

@freezed
sealed class ShopOrderListState with _$ShopOrderListState {
  const factory ShopOrderListState({
    @Default(ApiResponseInitial()) ApiResponse<Query$shopOrders> shopOrderList,
    @Default(ApiResponseInitial())
    ApiResponse<Query$getShopOrdersOverview> statistics,
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopCategories> shopCategories,
    String? searchQuery,
    Input$OffsetPaging? paging,
    required List<Input$ShopOrderSort> sorting,
    @Default([]) List<Enum$ShopOrderStatus> shopOrderStatus,
    @Default([]) List<Fragment$shopCategory> listShopCategoryFilter,
    @Default([]) List<String> listShopCategoryFilterId,
  }) = _ShopOrderListState;

  const ShopOrderListState._();

  factory ShopOrderListState.initial() => ShopOrderListState(
    sorting: [
      Input$ShopOrderSort(
        field: Enum$ShopOrderSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );

  int get completedShopOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ShopOrderStatus.Completed,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get errorShopOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ShopOrderStatus.Cancelled ||
                element.groupBy?.status == Enum$ShopOrderStatus.Returned,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get pendingShopOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ShopOrderStatus.Processing ||
                element.groupBy?.status == Enum$ShopOrderStatus.New,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get sentShopOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ShopOrderStatus.OutForDelivery,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get onHoldShopOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) => element.groupBy?.status == Enum$ShopOrderStatus.OnHold,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get totalShopOrdersCount =>
      statistics.data?.groupByStatus.fold<int>(
        0,
        (previousValue, element) => previousValue + (element.count?.id ?? 0),
      ) ??
      0;

  int get lastWeekShOpOrdersCount =>
      statistics.data?.lastWeekOrder.fold<int>(
        0,
        (previousValue, element) => previousValue + (element.count?.id ?? 0),
      ) ??
      0;

  int get completionRate => totalShopOrdersCount == 0
      ? 0
      : (completedShopOrdersCount * 100) ~/ totalShopOrdersCount;
}
