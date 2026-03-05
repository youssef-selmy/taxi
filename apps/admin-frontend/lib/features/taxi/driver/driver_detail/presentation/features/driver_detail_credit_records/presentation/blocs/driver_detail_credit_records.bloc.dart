import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/graphql/driver_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/repositories/driver_detail_credit_records_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_detail_credit_records.state.dart';
part 'driver_detail_credit_records.bloc.freezed.dart';

class DriverDetailCreditRecordsBloc
    extends Cubit<DriverDetailCreditRecordsState> {
  final DriverDetailCreditRecordsRepository
  _driverDetailCreditRecordsRepository =
      locator<DriverDetailCreditRecordsRepository>();

  DriverDetailCreditRecordsBloc()
    : super(
        // ignore: prefer_const_constructors
        DriverDetailCreditRecordsState.initial(),
      );

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
    _fetchDriverWallets();
    _fetchDriverCreditRecords();
  }

  Future<void> _fetchDriverCreditRecords() async {
    emit(state.copyWith(driverCreditRecordsState: const ApiResponse.loading()));

    var driverCreditRecordsOrError = await _driverDetailCreditRecordsRepository
        .getDriverCreditRecords(
          paging: state.paging,
          filter: state.filter,
          sorting: state.sorting,
        );

    emit(state.copyWith(driverCreditRecordsState: driverCreditRecordsOrError));
  }

  Future<void> _fetchDriverWallets() async {
    emit(state.copyWith(driverWalletsState: const ApiResponse.loading()));

    var driverWalletsOrError = await _driverDetailCreditRecordsRepository
        .getDriverWallets(driverId: state.driverId!);

    emit(state.copyWith(driverWalletsState: driverWalletsOrError));
  }

  Future<void> fetchEarningsOverTimeStatistics() async {
    emit(
      state.copyWith(
        earningsOverTimeStatisticsState: const ApiResponse.loading(),
      ),
    );

    var earningsOverTimeStatisticsOrError =
        await _driverDetailCreditRecordsRepository
            .getEarningsOverTimeStatistics(
              filter: state.earningsOverTimeFilter,
            );

    emit(
      state.copyWith(
        earningsOverTimeStatisticsState: earningsOverTimeStatisticsOrError,
      ),
    );
  }

  void onStatusFilterChanged(List<Enum$TransactionStatus> value) {
    emit(state.copyWith(transactionStatusFilter: value));
    _fetchDriverCreditRecords();
  }

  void onSortingChanged(List<Input$DriverTransactionSort> value) {
    emit(state.copyWith(sorting: value));
    _fetchDriverCreditRecords();
  }

  void onTransactionFilterChanged(List<Enum$TransactionAction> value) {
    emit(state.copyWith(transactionActionFilter: value));
    _fetchDriverCreditRecords();
  }

  void onEarningsOverTimeFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(earningsOverTimeFilter: filterInput));
    fetchEarningsOverTimeStatistics();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchDriverCreditRecords();
  }

  void onExport(Enum$ExportFormat format) async {
    emit(state.copyWith(exportState: const ApiResponse.loading()));
    final exportOrError = await _driverDetailCreditRecordsRepository
        .exportDriverCreditRecords(
          filter: state.filter,
          sort: state.sorting,
          format: format,
        );
    emit(state.copyWith(exportState: exportOrError));
  }
}
