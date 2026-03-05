import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/graphql/taxi_order_list.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/repositories/taxi_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'taxi_orders_archive_list.state.dart';
part 'taxi_orders_archive_list.cubit.freezed.dart';

class TaxiOrdersArchiveListBloc extends Cubit<TaxiOrdersArchiveListState> {
  final TaxiOrderListRepository _ordersRepository =
      locator<TaxiOrderListRepository>();

  final TaxiOrderRepository _taxiOrderRepository =
      locator<TaxiOrderRepository>();

  TaxiOrdersArchiveListBloc() : super(TaxiOrdersArchiveListState.initial());

  void onStarted() {
    _fetchOrdersList();
    _fetchFleetList();
    _fetchStatistics();
  }

  Future<void> _fetchOrdersList() async {
    emit(state.copyWith(ordersList: const ApiResponse.loading()));

    final taxiOrderListOrError = await _taxiOrderRepository.getAll(
      paging: state.paging?.toPaginationInput,
      filter: Input$TaxiOrderFilterInput(
        fleetId: state.fleetFilterId,
        status: state.statusFilter,
      ),
      sorting: null,
    );

    final networkStateOrders = taxiOrderListOrError;
    emit(state.copyWith(ordersList: networkStateOrders));
  }

  Future<void> _fetchFleetList() async {
    emit(state.copyWith(fleets: const ApiResponse.loading()));
    final fleets = await _ordersRepository.getFleets();
    emit(state.copyWith(fleets: fleets));
  }

  void onPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(paging: paging));
    _fetchOrdersList();
  }

  void onSortingChanged(List<Input$OrderSort> value) {
    emit(state.copyWith(sorting: value));
    _fetchOrdersList();
  }

  void onFleetFilterChanged(List<Fragment$fleetListItem> fleetFilter) {
    emit(state.copyWith(fleetFilterList: fleetFilter));
    List<String> fleetIds = fleetFilter.map((e) => e.id).toList();

    emit(state.copyWith(fleetFilterId: fleetIds));
    _fetchOrdersList();
  }

  void onStatusFilterChanged(Enum$TaxiOrderStatus? statusFilter) {
    emit(state.copyWith(statusFilter: [?statusFilter]));
    _fetchOrdersList();
  }

  void _fetchStatistics() async {
    emit(state.copyWith(statistics: const ApiResponse.loading()));
    final statisticsOrError = await _ordersRepository.getTaxiOrderStatistics();
    final statisticsState = statisticsOrError;
    emit(state.copyWith(statistics: statisticsState));
  }
}
