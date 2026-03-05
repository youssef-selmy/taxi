import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/graphql/shop_accounting_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/repositories/shop_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_accounting_list.state.dart';
part 'shop_accounting_list.cubit.freezed.dart';

class ShopAccountingListBloc extends Cubit<ShopAccountingListState> {
  final ShopAccountingListRepository _shopAccountingListRepository =
      locator<ShopAccountingListRepository>();

  ShopAccountingListBloc() : super(ShopAccountingListState());

  void onStarted({required String currency}) {
    emit(state.copyWith(selectedCurrency: currency));
    _fetchWalletSummary();
    _fetchWalletList();
  }

  void _fetchWalletList() async {
    emit(state.copyWith(walletListState: const ApiResponse.loading()));
    final walletListOrError = await _shopAccountingListRepository.getWalletList(
      currency: state.selectedCurrency,
      sorting: state.walletSortings,
      paging: state.walletPaging,
    );
    final walletListState = walletListOrError;
    emit(state.copyWith(walletListState: walletListState));
  }

  void _fetchWalletSummary() async {
    emit(state.copyWith(walletSummaryState: const ApiResponse.loading()));
    final walletSummaryOrError = await _shopAccountingListRepository
        .getWalletsSummary(currency: state.selectedCurrency!);
    final walletSummaryState = walletSummaryOrError;
    emit(state.copyWith(walletSummaryState: walletSummaryState));
  }

  void onWalletPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(walletPaging: paging));
    _fetchWalletList();
  }

  void changeWalletSortings(List<Input$ShopWalletSort> p1) {
    emit(state.copyWith(walletSortings: p1));
    _fetchWalletList();
  }

  void changeCurrency(List<String> p1) {
    emit(state.copyWith(selectedCurrency: p1.lastOrNull));
    _fetchWalletList();
  }
}
