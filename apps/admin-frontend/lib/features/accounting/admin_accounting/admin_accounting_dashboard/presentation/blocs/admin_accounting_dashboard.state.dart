part of 'admin_accounting_dashboard.bloc.dart';

@freezed
sealed class AdminAccountingDashboardState
    with _$AdminAccountingDashboardState {
  const factory AdminAccountingDashboardState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$adminWalletSummary> summaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$adminTransactions> transactionsState,
    required String currency,
    Input$OffsetPaging? transactionsPaging,
    @Default([]) List<Input$ProviderTransactionSort> sort,
    required Input$ChartFilterInput chartFilterInput,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _AdminAccountingDashboardState;

  factory AdminAccountingDashboardState.initial() {
    final now = DateTime.now();
    return AdminAccountingDashboardState(
      currency: Env.defaultCurrency,
      chartFilterInput: Input$ChartFilterInput(
        interval: Enum$ChartInterval.Monthly,
        startDate: DateTime(now.year, now.month, 1),
        endDate: now,
      ),
    );
  }

  const AdminAccountingDashboardState._();

  ApiResponse<List<WalletBalanceItem>> get adminWallets => summaryState.mapData(
    (data) => data.adminWallets
        .map((wallet) => wallet.toWalletBalanceItem())
        .toList(),
  );

  ApiResponse<Fragment$totalDailyPair> get totalRevenue =>
      summaryState.mapData((data) => data.totalRevenue);

  ApiResponse<Fragment$totalDailyPair> get totalOutstandingUserBalances =>
      summaryState.mapData((data) => data.totaloutstandingUserBalances);

  ApiResponse<Fragment$totalDailyPair> get totalExpenses =>
      summaryState.mapData((data) => data.totalExpenses);

  ApiResponse<List<Fragment$financialTimeline>>
  get providerWalletBalanceHistory =>
      summaryState.mapData((data) => data.providerWalletBalanceHistory);
}
