import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/data/repositories/driver_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_detail_orders.state.dart';
part 'driver_detail_orders.bloc.freezed.dart';

class DriverDetailOrdersBloc extends Cubit<DriverDetailOrdersState> {
  final DriverDetailOrdersRepository _driverDetailOrdersRepository =
      locator<DriverDetailOrdersRepository>();

  final TaxiOrderRepository _taxiOrderRepository =
      locator<TaxiOrderRepository>();

  DriverDetailOrdersBloc()
    : super(
        // ignore: prefer_const_constructors
        DriverDetailOrdersState.initial(),
      );

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
    _fetchDriverOrders();
  }

  Future<void> _fetchDriverOrders() async {
    emit(state.copyWith(driverOrdersState: const ApiResponse.loading()));

    var driverOrdersOrError = await _taxiOrderRepository.getAll(
      paging: state.paging?.toPaginationInput,
      filter: Input$TaxiOrderFilterInput(
        driverId: state.driverId!,
        status: state.driverOrderStatusFilter,
      ),
      sorting: null,
    );

    emit(state.copyWith(driverOrdersState: driverOrdersOrError));
  }

  void fetchAllStatistics() {
    _fetchRideCompletionStatistics();
    _fetchRideAcceptanceStatistics();
    _fetchEarningsOverTimeStatistics();
  }

  Future<void> _fetchRideCompletionStatistics() async {
    emit(
      state.copyWith(
        rideCompletionStatisticsState: const ApiResponse.loading(),
      ),
    );

    var rideCompletionStatisticsOrError = await _driverDetailOrdersRepository
        .getRideCompletionStatistics();

    emit(
      state.copyWith(
        rideCompletionStatisticsState: rideCompletionStatisticsOrError,
      ),
    );
  }

  Future<void> _fetchRideAcceptanceStatistics() async {
    emit(
      state.copyWith(
        rideAcceptanceStatisticsState: const ApiResponse.loading(),
      ),
    );

    var rideAcceptanceStatisticsOrError = await _driverDetailOrdersRepository
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

    var earningsOverTimeStatisticsOrError = await _driverDetailOrdersRepository
        .getEarningsOverTimeStatistics(filter: state.earningsOverTimeFilter);

    emit(
      state.copyWith(
        earningsOverTimeStatisticsState: earningsOverTimeStatisticsOrError,
      ),
    );
  }

  void onStatusFilterChanged(List<Enum$TaxiOrderStatus> value) {
    emit(state.copyWith(driverOrderStatusFilter: value));
    _fetchDriverOrders();
  }

  void onSortingChanged(List<Input$OrderSort> value) {
    emit(state.copyWith(sorting: value));
    _fetchDriverOrders();
  }

  void onRideAcceptanceFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(rideAcceptanceFilter: filterInput));

    _fetchRideAcceptanceStatistics();
  }

  void onEarningsOverTimeFilterChanged(Input$ChartFilterInput filterInput) {
    emit(state.copyWith(earningsOverTimeFilter: filterInput));

    _fetchEarningsOverTimeStatistics();
  }

  void onPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(paging: p1));
    _fetchDriverOrders();
  }
}
