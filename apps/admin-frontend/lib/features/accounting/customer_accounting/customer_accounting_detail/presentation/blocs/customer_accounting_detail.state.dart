part of 'customer_accounting_detail.bloc.dart';

@freezed
sealed class CustomerAccountingDetailState
    with _$CustomerAccountingDetailState {
  const factory CustomerAccountingDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerWalletDetailSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$customerTransactions> transactionListState,
    String? currency,
    String? customerId,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Input$RiderTransactionSort> transactionSortings,
    @Default([]) List<Enum$TransactionAction> transactionActionFilter,
    Input$OffsetPaging? transactionsPaging,
  }) = _CustomerAccountingDetailState;
}
