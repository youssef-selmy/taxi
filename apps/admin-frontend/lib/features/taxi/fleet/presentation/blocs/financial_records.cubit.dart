import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'financial_records.state.dart';
part 'financial_records.cubit.freezed.dart';

class FleetFinancialRecordsBloc extends Cubit<FinancialRecordsState> {
  final FleetRepository _fleetRepository = locator<FleetRepository>();

  FleetFinancialRecordsBloc() : super(FinancialRecordsState.initial());

  void onStarted({required String fleetId}) {
    emit(state.copyWith(fleetId: fleetId));
    _fetchFleetWallet();
    _fetchFleetTransactions();
  }

  void _fetchFleetTransactions() async {
    emit(state.copyWith(fleetTransaction: const ApiResponse.loading()));

    final result = await _fleetRepository.getFleetTransactions(
      paging: state.paging,
      sorting: state.sortFields,
      filter: state.filter,
    );
    emit(state.copyWith(fleetTransaction: result));
  }

  void _fetchFleetWallet() async {
    emit(state.copyWith(fleetWallet: const ApiResponse.loading()));

    final result = await _fleetRepository.getFleetWallet();
    emit(state.copyWith(fleetWallet: result));
  }

  void onSortingChanged(List<Input$FleetTransactionSort> sorting) {
    emit(state.copyWith(sortFields: sorting, paging: null));
    _fetchFleetTransactions();
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchFleetTransactions();
  }

  void onStatusFilterChanged(List<Enum$TransactionStatus> p1) {
    emit(state.copyWith(statusFilter: p1, paging: null));
    _fetchFleetTransactions();
  }

  void onTransactionFilterChanged(List<Enum$TransactionAction> p1) {
    emit(state.copyWith(transactionFilter: p1, paging: null));

    _fetchFleetTransactions();
  }

  void onExport(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));

    final result = await _fleetRepository.exportFleetTransactions(
      filter: state.filter,
      sorting: state.sortFields,
      format: format,
    );

    emit(state.copyWith(exportState: result));
  }
}
