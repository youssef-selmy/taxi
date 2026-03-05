part of 'taxi_orders_list.bloc.dart';

@freezed
sealed class TaxiOrdersListState with _$TaxiOrdersListState {
  const factory TaxiOrdersListState({
    @Default(ApiResponseInitial()) ApiResponse<Query$taxiOrders> ordersList,
    @Default(ApiResponseInitial())
    ApiResponse<Query$getOrdersOverview> statistics,
    @Default(ApiResponseInitial()) ApiResponse<Query$fleets> fleets,
    Input$OffsetPaging? paging,
    @Default([]) List<String> fleetFilterId,
    @Default([]) List<Fragment$fleetListItem> fleetFilterList,
    @Default(Enum$TaxiOrderStatus.SearchingForDriver)
    Enum$TaxiOrderStatus activeOrdersTab,
    String? selectedOrderId,
    @Default(ApiResponseInitial())
    ApiResponse<Fragment$taxiOrderDetail> orderSummaryResponse,
    MapViewController? mapViewController,
  }) = _TaxiOrdersListState;

  const TaxiOrdersListState._();

  factory TaxiOrdersListState.initial() => TaxiOrdersListState();

  int get inProgressOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status?.statusGrouped ==
                TaxiOrderStatusGrouped.inProgress,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get bookOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status?.statusGrouped ==
                TaxiOrderStatusGrouped.booked,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get completedOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status?.statusGrouped ==
                TaxiOrderStatusGrouped.completed,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get errorOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status?.statusGrouped ==
                TaxiOrderStatusGrouped.error,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get totalOrdersCount =>
      statistics.data?.groupByStatus.fold<int>(
        0,
        (previousValue, element) => previousValue + (element.count?.id ?? 0),
      ) ??
      0;

  int get lastWeekOrdersCount =>
      statistics.data?.lastWeekRides.fold<int>(
        0,
        (previousValue, element) => previousValue + (element.count?.id ?? 0),
      ) ??
      0;

  int get thisWeekOrdersCount =>
      statistics.data?.thisWeekRides.fold<int>(
        0,
        (previousValue, element) => previousValue + (element.count?.id ?? 0),
      ) ??
      0;

  int get completionRate => totalOrdersCount == 0
      ? 0
      : (completedOrdersCount * 100) ~/ totalOrdersCount;
}
