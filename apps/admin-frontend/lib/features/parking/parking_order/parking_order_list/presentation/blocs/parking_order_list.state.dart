part of 'parking_order_list.cubit.dart';

@freezed
sealed class ParkingOrderListState with _$ParkingOrderListState {
  const factory ParkingOrderListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingOrderList> parkingOrderState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$getParkingOrdersOverview> statistics,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$ParkOrderSort> sorting,
    @Default([]) List<Enum$ParkOrderStatus> parkingOrderStatus,
  }) = _ParkingOrderListState;

  const ParkingOrderListState._();

  int get completedParkingOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ParkOrderStatus.COMPLETED,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get accepteParkingOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ParkOrderStatus.ACCEPTED,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get canceleParkingOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ParkOrderStatus.CANCELLED,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get paidParkingOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) => element.groupBy?.status == Enum$ParkOrderStatus.PAID,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get pendingParkingOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ParkOrderStatus.PENDING,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get rejectedParkingOrdersCount =>
      statistics.data?.groupByStatus
          .where(
            (element) =>
                element.groupBy?.status == Enum$ParkOrderStatus.REJECTED,
          )
          .fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.count?.id ?? 0),
          ) ??
      0;

  int get totalParkingOrdersCount =>
      statistics.data?.groupByStatus.fold<int>(
        0,
        (previousValue, element) => previousValue + (element.count?.id ?? 0),
      ) ??
      0;
}
