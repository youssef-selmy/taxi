part of 'shop_payout_session_list.cubit.dart';

@freezed
sealed class ShopPayoutSessionListState with _$ShopPayoutSessionListState {
  const factory ShopPayoutSessionListState({
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopsPendingPayoutSessions> pendingPayoutSessionsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopsPayoutSessions> payoutSessionsState,
    @Default(ApiResponseInitial())
    ApiResponse<Query$shopsPayoutTransactions> payoutTransactionsState,
    @Default(0) int selectedPendingPayoutSessionIndex,
    Input$OffsetPaging? sessionsPaging,
    Input$OffsetPaging? transactionsPaging,
    required String currency,
    @Default([]) List<Input$ShopTransactionSort> transactionsSort,
    @Default([]) List<Enum$TransactionStatus> transactionStatusFilter,
    @Default([]) List<Input$ShopPayoutSessionSort> payoutSessionSort,
    @Default([]) List<Enum$PayoutSessionStatus> payoutSessionStatusFilter,
  }) = _ShopPayoutSessionListState;

  const ShopPayoutSessionListState._();

  Fragment$shopPayoutSessionListItem? get selectedPendingPayoutSession =>
      pendingPayoutSessionsState.data?.pendingSessions.nodes.elementAtOrNull(
        selectedPendingPayoutSessionIndex,
      );

  // initial state
  factory ShopPayoutSessionListState.initial() {
    return ShopPayoutSessionListState(currency: Env.defaultCurrency);
  }
}
