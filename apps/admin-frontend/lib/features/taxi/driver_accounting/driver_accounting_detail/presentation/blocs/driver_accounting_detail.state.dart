part of 'driver_accounting_detail.cubit.dart';

@freezed
sealed class DriverAccountingDetailState with _$DriverAccountingDetailState {
  const factory DriverAccountingDetailState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$driverWalletDetailSummary> walletSummaryState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$driverTransactions> transactionListState,
    String? currency,
    String? driverId,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Input$DriverTransactionSort> transactionSortings,
    @Default([]) List<Enum$TransactionAction> transactionActionFilter,
    Input$OffsetPaging? transactionsPaging,
  }) = _DriverAccountingDetailState;
}
