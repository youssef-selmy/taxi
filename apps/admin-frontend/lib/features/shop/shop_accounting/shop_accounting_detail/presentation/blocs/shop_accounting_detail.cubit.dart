import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/data/graphql/shop_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/data/repositories/shop_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_accounting_detail.state.dart';
part 'shop_accounting_detail.cubit.freezed.dart';

class ShopAccountingDetailBloc extends Cubit<ShopAccountingDetailState> {
  final ShopAccountingDetailRepository _shopAccountingDetailRepository =
      locator<ShopAccountingDetailRepository>();

  ShopAccountingDetailBloc() : super(ShopAccountingDetailState());

  void onStarted({required String currency, required String shopId}) {
    emit(ShopAccountingDetailState(currency: currency, shopId: shopId));
    _fetchWalletDetailSummary();
    _fetchShopTransactions();
  }

  void _fetchWalletDetailSummary() async {
    emit(state.copyWith(walletSummaryState: const ApiResponse.loading()));
    final walletDetailSummaryOrError = await _shopAccountingDetailRepository
        .getWalletDetailSummary(shopId: state.shopId!);
    final walletDetailSummaryState = walletDetailSummaryOrError;
    emit(state.copyWith(walletSummaryState: walletDetailSummaryState));
  }

  void _fetchShopTransactions() async {
    emit(state.copyWith(transactionListState: const ApiResponse.loading()));
    final shopTransactionsOrError = await _shopAccountingDetailRepository
        .getShopTransactions(
          currency: state.currency!,
          shopId: state.shopId!,
          sorting: state.transactionSortings,
          statusFilter: state.transactionStatusFilter,
          typeFilter: state.transactionTypeFilter,
          paging: state.transactionsPaging,
        );
    final shopTransactionsState = shopTransactionsOrError;
    emit(state.copyWith(transactionListState: shopTransactionsState));
  }

  void onTransactionStatusFilterChanged(
    List<Enum$TransactionStatus> selectedItems,
  ) {
    emit(state.copyWith(transactionStatusFilter: selectedItems));
    _fetchShopTransactions();
  }

  void onTransactionTypeFilterChanged(
    List<Enum$TransactionType> selectedItems,
  ) {
    emit(state.copyWith(transactionTypeFilter: selectedItems));
    _fetchShopTransactions();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(transactionsPaging: p1));
    _fetchShopTransactions();
  }
}
