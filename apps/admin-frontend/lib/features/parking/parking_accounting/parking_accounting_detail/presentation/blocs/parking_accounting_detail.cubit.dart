import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/data/graphql/parking_accounting_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/data/repositories/parking_accounting_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'parking_accounting_detail.state.dart';
part 'parking_accounting_detail.cubit.freezed.dart';

class ParkingAccountingDetailBloc extends Cubit<ParkingAccountingDetailState> {
  final ParkingAccountingDetailRepository _parkingAccountingDetailRepository =
      locator<ParkingAccountingDetailRepository>();

  ParkingAccountingDetailBloc() : super(ParkingAccountingDetailState());

  void onStarted({required String currency, required String parkingId}) {
    emit(
      ParkingAccountingDetailState(currency: currency, parkingId: parkingId),
    );
    _fetchWalletDetailSummary();
    _fetchParkingTransactions();
  }

  void _fetchWalletDetailSummary() async {
    emit(state.copyWith(walletSummaryState: const ApiResponse.loading()));
    final walletDetailSummaryOrError = await _parkingAccountingDetailRepository
        .getWalletDetailSummary(parkingId: state.parkingId!);
    final walletDetailSummaryState = walletDetailSummaryOrError;
    emit(state.copyWith(walletSummaryState: walletDetailSummaryState));
  }

  void _fetchParkingTransactions() async {
    emit(state.copyWith(transactionListState: const ApiResponse.loading()));
    final parkingTransactionsOrError = await _parkingAccountingDetailRepository
        .getParkingTransactions(
          currency: state.currency!,
          parkingId: state.parkingId!,
          sorting: state.transactionSortings,
          statusFilter: state.transactionStatusFilter,
          typeFilter: state.transactionTypeFilter,
          paging: state.transactionsPaging,
        );
    final parkingTransactionsState = parkingTransactionsOrError;
    emit(state.copyWith(transactionListState: parkingTransactionsState));
  }

  void onTransactionsPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(transactionsPaging: paging));
    _fetchParkingTransactions();
  }

  void onTransactionStatusFilterChanged(
    List<Enum$TransactionStatus> selectedItems,
  ) {
    emit(state.copyWith(transactionStatusFilter: selectedItems));
    _fetchParkingTransactions();
  }

  void onTransactionTypeFilterChanged(
    List<Enum$TransactionType> selectedItems,
  ) {
    emit(state.copyWith(transactionTypeFilter: selectedItems));
    _fetchParkingTransactions();
  }

  void onPageChanged(Input$OffsetPaging p1) {}
}
