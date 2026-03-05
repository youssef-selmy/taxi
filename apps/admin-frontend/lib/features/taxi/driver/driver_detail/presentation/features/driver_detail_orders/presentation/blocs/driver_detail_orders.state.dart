part of 'driver_detail_orders.bloc.dart';

@freezed
sealed class DriverDetailOrdersState with _$DriverDetailOrdersState {
  const factory DriverDetailOrdersState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$taxiOrders> driverOrdersState,
    String? driverId,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$OrderSort> sorting,
    @Default([]) List<Enum$TaxiOrderStatus> driverOrderStatusFilter,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$GenderDistribution>>
    rideCompletionStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>
    earningsOverTimeStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$RevenuePerApp>> rideAcceptanceStatisticsState,
    required Input$ChartFilterInput rideAcceptanceFilter,
    required Input$ChartFilterInput earningsOverTimeFilter,
  }) = _DriverDetailOrdersState;

  const DriverDetailOrdersState._();

  factory DriverDetailOrdersState.initial() {
    final year = DateTime.now().year;
    final startOfYear = DateTime(year);
    final endOfYear = DateTime(year + 1);
    return DriverDetailOrdersState(
      rideAcceptanceFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
      earningsOverTimeFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
    );
  }
}
