part of 'shop_accounting_detail.cubit.dart';

@freezed
sealed class ShopAccountingDetailState with _$ShopAccountingDetailState {
  const factory ShopAccountingDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopWalletDetailSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopTransactions> transactionListState,
    String? currency,
    String? shopId,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Input$ShopTransactionSort> transactionSortings,
    @Default([]) List<Enum$TransactionType> transactionTypeFilter,
    Input$OffsetPaging? transactionsPaging,
  }) = _ShopAccountingDetailState;
}
