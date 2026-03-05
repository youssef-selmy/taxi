part of 'parking_payout_session_list.cubit.dart';

@freezed
sealed class ParkingPayoutSessionListState
    with _$ParkingPayoutSessionListState {
  const factory ParkingPayoutSessionListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingsPendingPayoutSessions> pendingPayoutSessionsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingsPayoutSessions> payoutSessionsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$parkingsPayoutTransactions> payoutTransactionsState,
    @Default(0) int selectedPendingPayoutSessionIndex,
    Input$OffsetPaging? sessionsPaging,
    Input$OffsetPaging? transactionsPaging,
    required String currency,
    @Default([]) List<Input$ParkingTransactionSort> transactionsSort,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Input$ParkingPayoutSessionSort> payoutSessionSort,
    @Default([]) List<Enum$PayoutSessionStatus> payoutSessionStatusFilter,
  }) = _ParkingPayoutSessionListState;

  const ParkingPayoutSessionListState._();

  Fragment$parkingPayoutSessionListItem? get selectedPendingPayoutSession =>
      pendingPayoutSessionsState.data?.pendingSessions.nodes.elementAtOrNull(
        selectedPendingPayoutSessionIndex,
      );

  // initial state
  factory ParkingPayoutSessionListState.initial() {
    return ParkingPayoutSessionListState(currency: Env.defaultCurrency);
  }
}
