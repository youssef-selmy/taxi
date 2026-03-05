import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/data/graphql/driver_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_detail/data/repositories/driver_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_accounting_detail.state.dart';
part 'driver_accounting_detail.cubit.freezed.dart';

class DriverAccountingDetailBloc extends Cubit<DriverAccountingDetailState> {
  final DriverAccountingDetailRepository _driverAccountingDetailRepository =
      locator<DriverAccountingDetailRepository>();

  DriverAccountingDetailBloc() : super(DriverAccountingDetailState());

  void onStarted({required String currency, required String driverId}) {
    emit(DriverAccountingDetailState(currency: currency, driverId: driverId));
    _fetchWalletDetailSummary();
    _fetchDriverTransactions();
  }

  void _fetchWalletDetailSummary() async {
    emit(state.copyWith(walletSummaryState: const ApiResponse.loading()));
    final walletDetailSummaryOrError = await _driverAccountingDetailRepository
        .getWalletDetailSummary(driverId: state.driverId!);
    final walletDetailSummaryState = walletDetailSummaryOrError;
    emit(state.copyWith(walletSummaryState: walletDetailSummaryState));
  }

  void _fetchDriverTransactions() async {
    emit(state.copyWith(transactionListState: const ApiResponse.loading()));
    final driverTransactionsOrError = await _driverAccountingDetailRepository
        .getDriverTransactions(
          currency: state.currency!,
          driverId: state.driverId!,
          sorting: state.transactionSortings,
          statusFilter: state.transactionStatusFilter,
          actionFilter: state.transactionActionFilter,
          paging: state.transactionsPaging,
        );
    final driverTransactionsState = driverTransactionsOrError;
    emit(state.copyWith(transactionListState: driverTransactionsState));
  }

  void onTransactionStatusFilterChanged(
    List<Enum$TransactionStatus> selectedItems,
  ) {
    emit(state.copyWith(transactionStatusFilter: selectedItems));
    _fetchDriverTransactions();
  }

  void onTransactionActionFilterChanged(
    List<Enum$TransactionAction> selectedItems,
  ) {
    emit(state.copyWith(transactionActionFilter: selectedItems));
    _fetchDriverTransactions();
  }

  void onTransactionsPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(transactionsPaging: p1));
    _fetchDriverTransactions();
  }
}
