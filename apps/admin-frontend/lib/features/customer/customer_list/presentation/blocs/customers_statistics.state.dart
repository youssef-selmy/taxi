part of 'customers_statistics.cubit.dart';

@freezed
sealed class CustomersStatisticsState with _$CustomersStatisticsState {
  const factory CustomersStatisticsState({
    @Default(ApiResponseInitial()) ApiResponse<Query$CustomersStatistics> stats,
    required Input$ChartFilterInput revenueFilter,
    required Input$ChartFilterInput retentionFilter,
    required Input$ChartFilterInput activeInactiveUsersFilter,
  }) = _CustomersStatisticsState;

  const CustomersStatisticsState._();

  // constructor for initial state
  factory CustomersStatisticsState.initial() {
    final year = DateTime.now().year;
    final startOfYear = DateTime(year);
    final endOfYear = DateTime(year + 1);
    return CustomersStatisticsState(
      revenueFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
      retentionFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
      activeInactiveUsersFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
    );
  }

  int get totalCustomersCount =>
      stats.data?.customersPerApp.fold(
        0,
        (previousValue, element) => (previousValue ?? 0) + element.count,
      ) ??
      0;
}
