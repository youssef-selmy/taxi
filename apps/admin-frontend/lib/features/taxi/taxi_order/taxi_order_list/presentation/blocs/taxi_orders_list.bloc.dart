import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/graphql/taxi_order_list.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/repositories/taxi_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:generic_map/generic_map.dart';

part 'taxi_orders_list.state.dart';
part 'taxi_orders_list.event.dart';
part 'taxi_orders_list.bloc.freezed.dart';

class TaxiOrdersListBloc
    extends Bloc<TaxiOrdersListEvent, TaxiOrdersListState> {
  final TaxiOrderListRepository _ordersRepository =
      locator<TaxiOrderListRepository>();

  final TaxiOrderRepository _taxiOrderRepository =
      locator<TaxiOrderRepository>();

  TaxiOrdersListBloc() : super(TaxiOrdersListState.initial()) {
    on<TaxiOrdersListEvent>(
      (event, emit) async => switch (event) {
        _Started() => await _onStarted(emit),
        _PageChanged() => await _onPageChanged(event, emit),
        _SortingChanged() => await _onSortingChanged(event, emit),
        _FleetFilterChanged() => await _onFleetFilterChanged(event, emit),
        _StatusFilterChanged() => await _onStatusFilterChanged(event, emit),
        _SelectOrder() => await _onSelectOrder(event, emit),
        _OnOrderSelected() => throw UnimplementedError(),
        _MapViewControllerChanged() => await _onMapViewControllerChanged(
          event,
          emit,
        ),
      },
    );
  }

  Future<void> _onStarted(Emitter<TaxiOrdersListState> emit) async {
    await _onFetchOrders(emit);
    await _onFetchFleets(emit);
    await _onFetchStatistics(emit);
  }

  Future<void> _onFetchOrders(Emitter<TaxiOrdersListState> emit) async {
    emit(state.copyWith(ordersList: const ApiResponse.loading()));

    final taxiOrderListOrError = await _taxiOrderRepository.getAll(
      paging: state.paging?.toPaginationInput,
      filter: Input$TaxiOrderFilterInput(
        fleetId: state.fleetFilterId,
        status: [state.activeOrdersTab],
      ),
      sorting: null,
    );

    emit(state.copyWith(ordersList: taxiOrderListOrError));
  }

  Future<void> _onFetchFleets(Emitter<TaxiOrdersListState> emit) async {
    emit(state.copyWith(fleets: const ApiResponse.loading()));
    final fleets = await _ordersRepository.getFleets();
    emit(state.copyWith(fleets: fleets));
  }

  Future<void> _onFetchStatistics(Emitter<TaxiOrdersListState> emit) async {
    emit(state.copyWith(statistics: const ApiResponse.loading()));
    final statisticsOrError = await _ordersRepository.getTaxiOrderStatistics();
    emit(state.copyWith(statistics: statisticsOrError));
  }

  Future<void> _onPageChanged(
    _PageChanged event,
    Emitter<TaxiOrdersListState> emit,
  ) async {
    emit(state.copyWith(paging: event.paging));
    await _onFetchOrders(emit);
  }

  Future<void> _onSortingChanged(
    _SortingChanged event,
    Emitter<TaxiOrdersListState> emit,
  ) async {
    await _onFetchOrders(emit);
  }

  Future<void> _onFleetFilterChanged(
    _FleetFilterChanged event,
    Emitter<TaxiOrdersListState> emit,
  ) async {
    emit(state.copyWith(fleetFilterList: event.fleetFilter));
    final fleetIds = event.fleetFilter.map((e) => e.id).toList();
    emit(state.copyWith(fleetFilterId: fleetIds));
    await _onFetchOrders(emit);
  }

  Future<void> _onStatusFilterChanged(
    _StatusFilterChanged event,
    Emitter<TaxiOrdersListState> emit,
  ) async {
    emit(state.copyWith(activeOrdersTab: event.statusFilter.first));
    await _onFetchOrders(emit);
  }

  Future<void> _onSelectOrder(
    _SelectOrder event,
    Emitter<TaxiOrdersListState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedOrderId: event.orderId,
        orderSummaryResponse: const ApiResponse.loading(),
      ),
    );
    final orderDetailResponse = await _taxiOrderRepository.getOne(
      orderId: event.orderId,
    );
    emit(state.copyWith(orderSummaryResponse: orderDetailResponse));
    if (orderDetailResponse.isLoaded) {
      if (state.mapViewController == null) {
        if (kDebugMode) {
          print("MapViewController is null to fit bounds");
          return;
        }
      }
      final points = (orderDetailResponse.data?.waypoints.toLatLngs() ?? [])
          .followedBy([
            ?orderDetailResponse.data?.driver?.location?.toLatLngLib(),
          ])
          .toList();

      state.mapViewController?.fitBounds(points);
    }
  }

  Future _onMapViewControllerChanged(
    _MapViewControllerChanged event,
    Emitter<TaxiOrdersListState> emit,
  ) async {
    emit(state.copyWith(mapViewController: event.mapViewController));
  }
}
