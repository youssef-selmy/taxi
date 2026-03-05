import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/graphql/driver_accounting_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/repositories/driver_accounting_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_accounting_list.state.dart';
part 'driver_accounting_list.cubit.freezed.dart';

class DriverAccountingListBloc extends Cubit<DriverAccountingListState> {
  final DriverAccountingListRepository _driverAccountingListRepository =
      locator<DriverAccountingListRepository>();

  DriverAccountingListBloc() : super(DriverAccountingListState());

  void onStarted({required String currency}) {
    emit(state.copyWith(selectedCurrency: currency));
    _fetchWalletSummary();
    _fetchWalletList();
  }

  void _fetchWalletList() async {
    emit(state.copyWith(walletListState: const ApiResponse.loading()));
    final walletListOrError = await _driverAccountingListRepository
        .getWalletList(
          currency: state.selectedCurrency,
          sorting: state.walletSortings,
          paging: state.walletPaging,
        );
    final walletListState = walletListOrError;
    emit(state.copyWith(walletListState: walletListState));
  }

  void _fetchWalletSummary() async {
    emit(state.copyWith(walletSummaryState: const ApiResponse.loading()));
    final walletSummaryOrError = await _driverAccountingListRepository
        .getWalletsSummary(currency: state.selectedCurrency!);
    final walletSummaryState = walletSummaryOrError;
    emit(state.copyWith(walletSummaryState: walletSummaryState));
  }

  void changeWalletSortings(List<Input$DriverWalletSort> p1) {
    emit(state.copyWith(walletSortings: p1));
    _fetchWalletList();
  }

  void changeCurrency(List<String> p1) {
    emit(state.copyWith(selectedCurrency: p1.lastOrNull));
    _fetchWalletList();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(walletPaging: p1));
    _fetchWalletList();
  }
}
