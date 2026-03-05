part of 'taxi_orders_archive_list.cubit.dart';

@freezed
sealed class TaxiOrdersArchiveListState with _$TaxiOrdersArchiveListState {
  const factory TaxiOrdersArchiveListState({
    @Default(ApiResponseInitial()) ApiResponse<Query$taxiOrders> ordersList,
    @Default(ApiResponseInitial())
    ApiResponse<Query$getOrdersOverview> statistics,
    @Default(ApiResponseInitial()) ApiResponse<Query$fleets> fleets,
    Input$OffsetPaging? paging,
    required List<Input$OrderSort> sorting,
    @Default([
      Enum$TaxiOrderStatus.Completed,
      Enum$TaxiOrderStatus.Canceled,
      Enum$TaxiOrderStatus.Expired,
    ])
    List<Enum$TaxiOrderStatus> statusFilter,
    @Default([]) List<String> fleetFilterId,
    @Default([]) List<Fragment$fleetListItem> fleetFilterList,
  }) = _TaxiOrdersArchiveListState;

  const TaxiOrdersArchiveListState._();

  factory TaxiOrdersArchiveListState.initial() => TaxiOrdersArchiveListState(
    sorting: [
      Input$OrderSort(
        field: Enum$OrderSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );

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
