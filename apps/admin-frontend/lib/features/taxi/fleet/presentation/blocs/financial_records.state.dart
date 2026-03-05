part of 'financial_records.cubit.dart';

@freezed
sealed class FinancialRecordsState with _$FinancialRecordsState {
  const factory FinancialRecordsState({
    required ApiResponse<Query$fleetTransactions> fleetTransaction,
    required ApiResponse<List<WalletBalanceItem>> fleetWallet,
    String? searchQuery,
    Input$OffsetPaging? paging,
    String? fleetId,
    @Default([]) List<Input$FleetTransactionSort> sortFields,
    @Default([]) List<Enum$TransactionStatus> statusFilter,
    @Default([]) List<Enum$TransactionAction> transactionFilter,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _FinancialRecordsState;

  factory FinancialRecordsState.initial() => FinancialRecordsState(
    fleetTransaction: const ApiResponse.initial(),
    fleetWallet: const ApiResponse.initial(),
  );

  const FinancialRecordsState._();

  Input$FleetTransactionFilter get filter => Input$FleetTransactionFilter(
    fleetId: Input$IDFilterComparison(eq: fleetId!),
    status: statusFilter.isEmpty
        ? null
        : Input$TransactionStatusFilterComparison($in: statusFilter),
    action: transactionFilter.isEmpty
        ? null
        : Input$TransactionActionFilterComparison($in: transactionFilter),
  );
}
