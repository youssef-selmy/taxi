import 'package:admin_frontend/config/env.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/repositories/driver_list_repository.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/repositories/driver_list_statistics_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_list.state.dart';
part 'driver_list.bloc.freezed.dart';

class DriverListBloc extends Cubit<DriverListState> {
  final DriverListRepository _driverListRepository =
      locator<DriverListRepository>();
  final DriverListStatisticsRepository _driverListStatisticsRepository =
      locator<DriverListStatisticsRepository>();

  DriverListBloc() : super(DriverListState.initial());

  void onStarted() {
    _fetchDrivers();
  }

  Future<void> _fetchDrivers() async {
    emit(state.copyWith(driversState: const ApiResponse.loading()));

    final driversListOrError = await _driverListRepository.getDrivers(
      paging: state.paging,
      filter: Input$DriverFilter(
        or: state.searchQuery?.isEmpty == false
            ? [
                Input$DriverFilter(
                  firstName: Input$StringFieldComparison(
                    like: '%${state.searchQuery}%',
                  ),
                ),
                Input$DriverFilter(
                  lastName: Input$StringFieldComparison(
                    like: '%${state.searchQuery}%',
                  ),
                ),
                Input$DriverFilter(
                  mobileNumber: Input$StringFieldComparison(
                    like: '%${state.searchQuery}%',
                  ),
                ),
                Input$DriverFilter(
                  carPlate: Input$StringFieldComparison(
                    like: '%${state.searchQuery}%',
                  ),
                ),
              ]
            : [],
        status: state.driverStatusFilter.isEmpty
            ? null
            : Input$DriverStatusFilterComparison($in: state.driverStatusFilter),
      ),
      sorting: state.sorting.isNotEmpty ? state.sorting : [],
    );

    emit(state.copyWith(driversState: driversListOrError));
  }

  void fetchAllDriverStatistics() {
    _fetchDriverStatistics();
    _fetchDriverActiveInActiveStatistics();
    _fetchRideCompletionStatistics();
    _fetchPerformingDriverStatistics();
    _fetchEarningDriverStatistics();
    _fetchTripsCompletedStatistics();
    _fetchRideAcceptanceStatistics();
    _fetchEarningsOverTimeStatistics();
    _fetchEarningsDistributionStatistics();
  }

  Future<void> _fetchDriverStatistics() async {
    emit(state.copyWith(driverStatisticsState: const ApiResponse.loading()));

    var driverStatisticsOrError = await _driverListStatisticsRepository
        .getDriverStatistics(currency: state.currency);

    emit(state.copyWith(driverStatisticsState: driverStatisticsOrError));
  }

  Future<void> _fetchDriverActiveInActiveStatistics() async {
    emit(
      state.copyWith(
        activeInActiveStatisticsState: const ApiResponse.loading(),
      ),
    );

    var driverActiveInActiveStatisticsOrError =
        await _driverListStatisticsRepository.getActiveInActiveStatistics();

    emit(
      state.copyWith(
        activeInActiveStatisticsState: driverActiveInActiveStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchRideCompletionStatistics() async {
    emit(
      state.copyWith(
        rideCompletionStatisticsState: const ApiResponse.loading(),
      ),
    );

    var rideCompletionStatisticsOrError = await _driverListStatisticsRepository
        .getRideCompletionStatistics();

    emit(
      state.copyWith(
        rideCompletionStatisticsState: rideCompletionStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchPerformingDriverStatistics() async {
    emit(
      state.copyWith(
        topDriversWithCompletedTripsState: const ApiResponse.loading(),
      ),
    );

    var performingDriverStatisticsOrError =
        await _driverListStatisticsRepository.getTopRideAcceptanceDrivers();

    emit(
      state.copyWith(
        topDriversWithCompletedTripsState: performingDriverStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchEarningDriverStatistics() async {
    emit(
      state.copyWith(topDriversWithEarningsState: const ApiResponse.loading()),
    );

    var performingDriverStatisticsOrError =
        await _driverListStatisticsRepository.getTopEarningDrivers(
          currency: state.currency,
        );

    emit(
      state.copyWith(
        topDriversWithEarningsState: performingDriverStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchTripsCompletedStatistics() async {
    emit(
      state.copyWith(
        tripsCompletedStatisticsState: const ApiResponse.loading(),
      ),
    );

    var tripsCompletedStatisticsOrError = await _driverListStatisticsRepository
        .getTripsCompletedStatistics(filter: state.tripsCompletedFilter);

    emit(
      state.copyWith(
        tripsCompletedStatisticsState: tripsCompletedStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchRideAcceptanceStatistics() async {
    emit(
      state.copyWith(
        rideAcceptanceStatisticsState: const ApiResponse.loading(),
      ),
    );

    var rideAcceptanceStatisticsOrError = await _driverListStatisticsRepository
        .getRideAcceptanceStatistics(filter: state.rideAcceptanceFilter);

    emit(
      state.copyWith(
        rideAcceptanceStatisticsState: rideAcceptanceStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchEarningsOverTimeStatistics() async {
    emit(
      state.copyWith(
        earningsOverTimeStatisticsState: const ApiResponse.loading(),
      ),
    );

    var earningsOverTimeStatisticsOrError =
        await _driverListStatisticsRepository.getEarningsOverTimeStatistics(
          filter: state.rideAcceptanceFilter,
        );

    emit(
      state.copyWith(
        earningsOverTimeStatisticsState: earningsOverTimeStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchEarningsDistributionStatistics() async {
    emit(
      state.copyWith(
        earningsDistributionStatisticsState: const ApiResponse.loading(),
      ),
    );

    var earningsDistributionStatisticsOrError =
        await _driverListStatisticsRepository.getEarningsDistributionStatistics(
          filter: state.rideAcceptanceFilter,
        );

    emit(
      state.copyWith(
        earningsDistributionStatisticsState:
            earningsDistributionStatisticsOrError,
      ),
    );
  }

  void onCurrencyChange(String currency) {
    emit(state.copyWith(currency: currency));
    _fetchDriverStatistics();
    _fetchEarningDriverStatistics();
  }

  void onStatusFilterChanged(List<Enum$DriverStatus> value) {
    emit(state.copyWith(driverStatusFilter: value));
    _fetchDrivers();
  }

  void onDriverStatusChanged(String id, Enum$DriverStatus value) async {
    emit(state.copyWith(driverUpdateState: const ApiResponse.initial()));

    var driverStatusUpdateOrFail = await _driverListRepository
        .updateDriverStatus(id: id, status: value);
    emit(state.copyWith(driverUpdateState: driverStatusUpdateOrFail));
    _fetchDrivers();
  }

  void onSortingChanged(List<Input$DriverSort> value) {
    emit(state.copyWith(sorting: value));
    _fetchDrivers();
  }

  void onSearchQueryChanged(String value) {
    emit(state.copyWith(searchQuery: value));
    _fetchDrivers();
  }

  void onTripsCompletedFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(tripsCompletedFilter: filterInput));

    _fetchTripsCompletedStatistics();
  }

  void onRideAcceptanceFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(rideAcceptanceFilter: filterInput));

    _fetchRideAcceptanceStatistics();
  }

  void onEarningsOverTimeFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(earningsOverTimeFilter: filterInput));

    _fetchEarningsOverTimeStatistics();
  }

  void onEarningsDistributionFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(earningsDistributionFilter: filterInput));

    _fetchEarningsDistributionStatistics();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchDrivers();
  }

  void refresh() {
    _fetchDrivers();
  }
}
