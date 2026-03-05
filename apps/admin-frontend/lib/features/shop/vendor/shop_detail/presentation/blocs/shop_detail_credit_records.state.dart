part of 'shop_detail_credit_records.bloc.dart';

@freezed
sealed class ShopDetailCreditRecordsState with _$ShopDetailCreditRecordsState {
  const factory ShopDetailCreditRecordsState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopCreditRecords> creditRecordsState,
    String? shopId,
    Input$OffsetPaging? paging,
    @Default([]) List<Enum$TransactionStatus> statusFilters,
    @Default([]) List<Enum$TransactionType> typeFilters,
    @Default([]) List<Input$ShopTransactionSort> sorting,
    @Default(ApiResponseInitial())
    ApiResponse<List<WalletBalanceItem>> walletState,
    @Default(ApiResponseInitial()) ApiResponse<String> exportState,
  }) = _ShopDetailCreditRecordsState;

  const ShopDetailCreditRecordsState._();

  Input$ShopTransactionFilter get filter => Input$ShopTransactionFilter(
    shopId: Input$IDFilterComparison(eq: shopId!),
    status: statusFilters.isEmpty
        ? null
        : Input$TransactionStatusFilterComparison($in: statusFilters),
    type: typeFilters.isEmpty
        ? null
        : Input$TransactionTypeFilterComparison($in: typeFilters),
  );
}
