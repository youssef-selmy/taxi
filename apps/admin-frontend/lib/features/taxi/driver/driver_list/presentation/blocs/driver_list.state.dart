part of 'driver_list.bloc.dart';

@freezed
sealed class DriverListState with _$DriverListState {
  const factory DriverListState({
    @Default(ApiResponse.initial()) ApiResponse<Query$drivers> driversState,
    @Default(ApiResponse.initial())
    ApiResponse<Mutation$updateDriverStatus> driverUpdateState,
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverStatistics> driverStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$RevenuePerApp>> tripsCompletedStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$RevenuePerApp>> rideAcceptanceStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$ActiveInactiveUsers>>
    activeInActiveStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<Query$rideCountByStatus> rideCompletionStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$leaderboardItem>>
    topDriversWithCompletedTripsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<Fragment$leaderboardItem>> topDriversWithEarningsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>
    earningsDistributionStatisticsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>
    earningsOverTimeStatisticsState,
    required Input$ChartFilterInput tripsCompletedFilter,
    required Input$ChartFilterInput rideAcceptanceFilter,
    required Input$ChartFilterInput earningsOverTimeFilter,
    required Input$ChartFilterInput earningsDistributionFilter,
    required String currency,
    String? searchQuery,
    Input$OffsetPaging? paging,
    required List<Input$DriverSort> sorting,
    @Default([]) List<Enum$DriverStatus> driverStatusFilter,
  }) = _DriverListState;

  const DriverListState._();

  factory DriverListState.initial() {
    final year = DateTime.now().year;
    final startOfYear = DateTime(year);
    final endOfYear = DateTime(year + 1);
    return DriverListState(
      currency: Env.defaultCurrency,
      tripsCompletedFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
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
      earningsDistributionFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
      sorting: [
        Input$DriverSort(
          field: Enum$DriverSortFields.id,
          direction: Enum$SortDirection.DESC,
        ),
      ],
    );
  }

  double get totalEarningsCount =>
      driverStatisticsState.data?.totalEarnings.fold<double>(
        0,
        (previousValue, element) => previousValue + (element.sum?.balance ?? 0),
      ) ??
      0;

  int get activeDriversCount =>
      driverStatisticsState.data?.activeDrivers.totalCount ?? 0;

  int get totalTripsCompletedCount =>
      driverStatisticsState.data?.totalTripsCompleted.totalCount ?? 0;

  double get averageRatings =>
      driverStatisticsState.data?.averageRatings.fold<double>(
        0,
        (previousValue, element) => previousValue + (element.avg?.rating ?? 0),
      ) ??
      0;
}
