import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'park_spot_detail_credit_records.state.dart';
part 'park_spot_detail_credit_records.cubit.freezed.dart';

class ParkSpotDetailCreditRecordsBloc
    extends Cubit<ParkSpotDetailCreditRecordsState> {
  final ParkSpotDetailCreditRecordsRepository
  _parkSpotDetailCreditRecordsRepository =
      locator<ParkSpotDetailCreditRecordsRepository>();

  ParkSpotDetailCreditRecordsBloc() : super(ParkSpotDetailCreditRecordsState());

  void onStarted({required String parkSpotId, required String ownerId}) {
    emit(state.copyWith(parkSpotId: parkSpotId, ownerId: ownerId));
    refresh();
  }

  void refresh() {
    _fetchCreditRecords();
    _fetchWalletBalance();
  }

  void _fetchWalletBalance() async {
    emit(state.copyWith(walletState: const ApiResponse.loading()));
    final walletBalanceOrError = await _parkSpotDetailCreditRecordsRepository
        .getWalletBalance(ownerId: state.ownerId!);
    final walletBalanceState = walletBalanceOrError;
    emit(state.copyWith(walletState: walletBalanceState));
  }

  void _fetchCreditRecords() async {
    emit(state.copyWith(creditRecordsState: const ApiResponse.loading()));
    final creditRecords = await _parkSpotDetailCreditRecordsRepository
        .getCreditRecords(
          paging: state.paging,
          sorting: state.sorting,
          filter: state.filter,
        );
    emit(state.copyWith(creditRecordsState: creditRecords));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchCreditRecords();
  }

  void onTransactionStatusFilterChanged(
    List<Enum$TransactionStatus> selectedItems,
  ) {
    emit(state.copyWith(statusFilters: selectedItems));
    _fetchCreditRecords();
  }

  void onTransactionSortChanged(
    List<Input$ParkingTransactionSort> selectedItems,
  ) {
    emit(state.copyWith(sorting: selectedItems));
    _fetchCreditRecords();
  }

  void onTransactionActionFilterChanged(
    List<Enum$TransactionType> selectedItems,
  ) {
    emit(state.copyWith(typeFilters: selectedItems));
    _fetchCreditRecords();
  }

  void export(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _parkSpotDetailCreditRecordsRepository
        .exportCreditRecords(
          filter: state.filter,
          sort: state.sorting,
          format: format,
        );
    final exportState = exportOrError;
    emit(state.copyWith(exportState: exportState));
  }
}
