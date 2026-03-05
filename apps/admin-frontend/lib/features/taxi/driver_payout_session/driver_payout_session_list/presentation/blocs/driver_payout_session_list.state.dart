part of 'driver_payout_session_list.cubit.dart';

@freezed
sealed class DriverPayoutSessionListState with _$DriverPayoutSessionListState {
  const factory DriverPayoutSessionListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$driversPendingPayoutSessions> pendingPayoutSessionsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$driversPayoutSessions> payoutSessionsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$driversPayoutTransactions> payoutTransactionsState,
    @Default(0) int selectedPendingPayoutSessionIndex,
    Input$OffsetPaging? sessionsPaging,
    Input$OffsetPaging? transactionsPaging,
    required String currency,
    @Default([]) List<Input$DriverTransactionSort> transactionsSort,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Input$TaxiPayoutSessionSort> payoutSessionSort,
    @Default([]) List<Enum$PayoutSessionStatus> payoutSessionStatusFilter,
  }) = _DriverPayoutSessionListState;

  const DriverPayoutSessionListState._();

  // initial state
  factory DriverPayoutSessionListState.initial() =>
      DriverPayoutSessionListState(currency: Env.defaultCurrency);

  Fragment$taxiPayoutSessionListItem? get selectedPendingPayoutSession =>
      pendingPayoutSessionsState.data?.pendingSessions.nodes.elementAtOrNull(
        selectedPendingPayoutSessionIndex,
      );
}
