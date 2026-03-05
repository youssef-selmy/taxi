part of 'parking_accounting_detail.cubit.dart';

@freezed
sealed class ParkingAccountingDetailState with _$ParkingAccountingDetailState {
  const factory ParkingAccountingDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingWalletDetailSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingTransactions> transactionListState,
    String? currency,
    String? parkingId,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Input$ParkingTransactionSort> transactionSortings,
    @Default([]) List<Enum$TransactionType> transactionTypeFilter,
    Input$OffsetPaging? transactionsPaging,
  }) = _ParkingAccountingDetailState;
}
