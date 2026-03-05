import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/graphql/shop_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/repositories/shop_payout_session_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_payout_session_list.state.dart';
part 'shop_payout_session_list.cubit.freezed.dart';

class ShopPayoutSessionListBloc extends Cubit<ShopPayoutSessionListState> {
  final ShopPayoutSessionListRepository _shopPayoutSessionListRepository =
      locator<ShopPayoutSessionListRepository>();

  ShopPayoutSessionListBloc() : super(ShopPayoutSessionListState.initial());

  void onStarted({required String currency}) {
    changeCurrency(currency: currency);
  }

  void changeCurrency({required String currency}) {
    emit(state.copyWith(currency: currency));
    _fetchPayoutSessions();
    _fetchPayoutTransactions();
    _fetchPendingTransactions();
  }

  void _fetchPendingTransactions() async {
    emit(
      state.copyWith(pendingPayoutSessionsState: const ApiResponse.loading()),
    );
    final transactionsOrError = await _shopPayoutSessionListRepository
        .getShopsPendingPayoutSessions();
    final transactionsState = transactionsOrError;
    emit(state.copyWith(pendingPayoutSessionsState: transactionsState));
  }

  void _fetchPayoutSessions() async {
    emit(state.copyWith(payoutSessionsState: const ApiResponse.loading()));
    final sessionsOrError = await _shopPayoutSessionListRepository
        .getShopsPayoutSessions(
          paging: state.sessionsPaging,
          sorting: state.payoutSessionSort,
          filter: Input$ShopPayoutSessionFilter(
            currency: Input$StringFieldComparison(eq: state.currency),
            status: state.payoutSessionStatusFilter.isEmpty
                ? null
                : Input$PayoutSessionStatusFilterComparison(
                    $in: state.payoutSessionStatusFilter,
                  ),
          ),
        );
    final sessionsState = sessionsOrError;
    emit(state.copyWith(payoutSessionsState: sessionsState));
  }

  void _fetchPayoutTransactions() async {
    emit(state.copyWith(payoutTransactionsState: const ApiResponse.loading()));
    final transactionsOrError = await _shopPayoutSessionListRepository
        .getShopsPayoutTransactions(
          paging: state.transactionsPaging,
          sorting: state.transactionsSort,
          filter: Input$ShopTransactionFilter(
            payoutSessionId: Input$IDFilterComparison($is: true),
            status: state.transactionStatusFilter.isEmpty
                ? null
                : Input$TransactionStatusFilterComparison(
                    $in: state.transactionStatusFilter,
                  ),
          ),
        );
    final transactionsState = transactionsOrError;
    emit(state.copyWith(payoutTransactionsState: transactionsState));
  }

  void onPendingSessionsPreviousItem() {
    if (state.selectedPendingPayoutSessionIndex < 1) return;
    emit(
      state.copyWith(
        selectedPendingPayoutSessionIndex:
            state.selectedPendingPayoutSessionIndex - 1,
      ),
    );
  }

  void onPendingSessionsNextItem() {
    if ((state.selectedPendingPayoutSessionIndex + 1) ==
        state.pendingPayoutSessionsState.data?.pendingSessions.totalCount) {
      return;
    }
    emit(
      state.copyWith(
        selectedPendingPayoutSessionIndex:
            state.selectedPendingPayoutSessionIndex + 1,
      ),
    );
  }

  void transactionSortChanged(List<Input$ShopTransactionSort> p1) {
    emit(state.copyWith(transactionsSort: p1));
    _fetchPayoutTransactions();
  }

  void onStatusFilterChanged(List<Enum$TransactionStatus> p1) {
    emit(state.copyWith(transactionStatusFilter: p1, transactionsPaging: null));
    _fetchPayoutTransactions();
  }

  void onSessionsSortChanged(List<Input$ShopPayoutSessionSort> sort) {
    emit(state.copyWith(payoutSessionSort: sort));
    _fetchPayoutSessions();
  }

  void onSessionStatusFilterChanged(List<Enum$PayoutSessionStatus> statuses) {
    emit(state.copyWith(payoutSessionStatusFilter: statuses));
    _fetchPayoutSessions();
  }

  void onSessionsPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(sessionsPaging: p1));
    _fetchPayoutSessions();
  }

  void onTransactionsPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(transactionsPaging: p1));
    _fetchPayoutTransactions();
  }
}
