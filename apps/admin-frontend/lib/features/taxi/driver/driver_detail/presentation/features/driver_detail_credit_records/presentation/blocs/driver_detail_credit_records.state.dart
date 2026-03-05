part of 'driver_detail_credit_records.bloc.dart';

@freezed
sealed class DriverDetailCreditRecordsState
    with _$DriverDetailCreditRecordsState {
  const factory DriverDetailCreditRecordsState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverCreditRecords> driverCreditRecordsState,
    @Default(ApiResponse.initial())
    ApiResponse<List<WalletBalanceItem>> driverWalletsState,
    Input$OffsetPaging? paging,
    @Default([]) List<Input$DriverTransactionSort> sorting,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Enum$TransactionAction> transactionActionFilter,
    String? driverId,
    @Default(ApiResponse.initial())
    ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>
    earningsOverTimeStatisticsState,
    required Input$ChartFilterInput earningsOverTimeFilter,
    @Default(ApiResponse.initial()) ApiResponse<String> exportState,
  }) = _DriverDetailCreditRecordsState;

  const DriverDetailCreditRecordsState._();

  factory DriverDetailCreditRecordsState.initial() {
    final year = DateTime.now().year;
    final startOfYear = DateTime(year);
    final endOfYear = DateTime(year + 1);
    return DriverDetailCreditRecordsState(
      earningsOverTimeFilter: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: startOfYear,
        endDate: endOfYear,
      ),
    );
  }

  Input$DriverTransactionFilter get filter => Input$DriverTransactionFilter(
    driverId: Input$IDFilterComparison(eq: driverId!),
    status: transactionStatusFilter.isEmpty
        ? null
        : Input$TransactionStatusFilterComparison($in: transactionStatusFilter),
    action: transactionActionFilter.isEmpty
        ? null
        : Input$TransactionActionFilterComparison($in: transactionActionFilter),
  );
}
