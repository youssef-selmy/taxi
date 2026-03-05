part of 'credit_records.cubit.dart';

@freezed
sealed class CreditRecordsState with _$CreditRecordsState {
  const factory CreditRecordsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerCreditRecords> creditRecordsState,
    String? customerId,
    Input$OffsetPaging? paging,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilters,
    @Default([]) List<Enum$TransactionAction> transactionActionFilters,
    @Default([]) List<Input$RiderTransactionSort> transactionSorts,
    @Default(ApiResponseInitial())
    ApiResponse<List<WalletBalanceItem>> walletState,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _CreditRecordsState;
}
