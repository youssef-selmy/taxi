import 'dart:async';

import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/data/graphql/taxi_overview.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/data/repositories/taxi_overview_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'taxi_overview.state.dart';
part 'taxi_overview.event.dart';
part 'taxi_overview.bloc.freezed.dart';

class TaxiOverviewBloc extends Bloc<TaxiOverviewEvent, TaxiOverviewState> {
  final TaxiOverviewRepository _taxiOverviewRepository =
      locator<TaxiOverviewRepository>();

  final TaxiOrderRepository _taxiOrderRepository =
      locator<TaxiOrderRepository>();

  TaxiOverviewBloc() : super(TaxiOverviewState.initial()) {
    on<TaxiOverviewEvent>((event, emit) async {
      switch (event) {
        case TaxiOverviewStarted():
          await _onStarted(event, emit);
          break;
        case TaxiOverviewCurrencyChanged():
          await _onCurrencyChanged(event, emit);
          break;
        case TaxiOverviewActiveOrdersPageChanged():
          await _onActiveOrdersPageChanged(event, emit);
          break;
        case TaxiOverviewDriversInViewPortFetch():
          await _onDriversInViewPortFetch(event, emit);
          break;
        case TaxiOverviewPendingDriversRefresh():
          await _onPendingDriversRefresh(event, emit);
      }
    });
  }

  Future<void> _onStarted(
    TaxiOverviewStarted event,
    Emitter<TaxiOverviewState> emit,
  ) async {
    emit(state.copyWith(currency: event.currency));
    await _fetchAll(emit);
    emit.forEach(
      _taxiOverviewRepository.onlineDriversClusters,
      onData: (data) {
        return state.copyWith(
          onlineDriversClusters: ApiResponse.loaded(data.data ?? []),
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          onlineDriversClusters: ApiResponse.error(error.toString()),
        );
      },
    );
    await emit.forEach(
      _taxiOverviewRepository.singleOnlineDrivers,
      onData: (data) {
        return state.copyWith(
          singleOnlineDrivers: ApiResponse.loaded(data.data ?? []),
        );
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          singleOnlineDrivers: ApiResponse.error(error.toString()),
        );
      },
    );
  }

  Future<void> _onCurrencyChanged(
    TaxiOverviewCurrencyChanged event,
    Emitter<TaxiOverviewState> emit,
  ) async {
    emit(state.copyWith(currency: event.currency));
    await _fetchKPIs(emit);
    await _fetchActiveOrders(emit);
  }

  Future<void> _onActiveOrdersPageChanged(
    TaxiOverviewActiveOrdersPageChanged event,
    Emitter<TaxiOverviewState> emit,
  ) async {
    emit(state.copyWith(activeOrdersPaging: event.page));
    await _fetchActiveOrders(emit);
  }

  Future<void> _onDriversInViewPortFetch(
    TaxiOverviewDriversInViewPortFetch event,
    Emitter<TaxiOverviewState> emit,
  ) async {
    emit(state.copyWith(onlineDriverMapBounds: event.bounds));
    await _fetchOnlineDrivers(emit);
  }

  Future<void> _onPendingDriversRefresh(
    TaxiOverviewPendingDriversRefresh event,
    Emitter<TaxiOverviewState> emit,
  ) async {
    await _fetchPendingDrivers(emit);
  }

  Future<void> _fetchAll(Emitter<TaxiOverviewState> emit) async {
    await Future.wait([
      _fetchKPIs(emit),
      _fetchActiveOrders(emit),
      _fetchPendingDrivers(emit),
      _fetchPendingSupportRequests(emit),
      _fetchTopPerformingDrivers(emit),
      _fetchTopSpendingCustomers(emit),
    ]);
  }

  Future<void> _fetchKPIs(Emitter<TaxiOverviewState> emit) async {
    emit(state.copyWith(kpisState: ApiResponse.loading()));
    final kpisOrError = await _taxiOverviewRepository.getKPIs(
      currency: state.currency!,
    );
    emit(state.copyWith(kpisState: kpisOrError));
  }

  Future<void> _fetchActiveOrders(Emitter<TaxiOverviewState> emit) async {
    emit(state.copyWith(activeOrdersState: ApiResponse.loading()));
    final activeOrdersOrError = await _taxiOrderRepository.getAll(
      filter: Input$TaxiOrderFilterInput(),
      paging: state.activeOrdersPaging?.toPaginationInput,
      sorting: null,
    );
    emit(state.copyWith(activeOrdersState: activeOrdersOrError));
  }

  Future<void> _fetchOnlineDrivers(Emitter<TaxiOverviewState> emit) async {
    emit(state.copyWith(onlineDriversState: ApiResponse.loading()));
    final onlineDriversOrError = await _taxiOverviewRepository.getOnlineDrivers(
      bounds: state.onlineDriverMapBounds!,
    );
    if (onlineDriversOrError.data != null) {
      _taxiOverviewRepository.startSubscribingToDriverClusters(
        h3Indexes: onlineDriversOrError
            .data!
            .driverLocationsByViewport
            .h3IndexesInView,
        h3Resolution:
            onlineDriversOrError.data!.driverLocationsByViewport.h3Resolution,
      );
      _taxiOverviewRepository.startSubscribingToDriverLocations(
        driverIds: onlineDriversOrError.data!.driverLocationsByViewport.singles
            .map((e) => e.driverId)
            .toList(),
      );
    }
    emit(state.copyWith(onlineDriversState: onlineDriversOrError));
  }

  Future<void> _fetchPendingDrivers(Emitter<TaxiOverviewState> emit) async {
    emit(state.copyWith(pendingDriversState: ApiResponse.loading()));
    final pendingDriversOrError = await _taxiOverviewRepository
        .getPendingDrivers();
    emit(state.copyWith(pendingDriversState: pendingDriversOrError));
  }

  Future<void> _fetchPendingSupportRequests(
    Emitter<TaxiOverviewState> emit,
  ) async {
    emit(state.copyWith(pendingSupportRequestsState: ApiResponse.loading()));
    final pendingSupportRequestsOrError = await _taxiOverviewRepository
        .getPendingSupportRequets();
    emit(
      state.copyWith(
        pendingSupportRequestsState: pendingSupportRequestsOrError,
      ),
    );
  }

  Future<void> _fetchTopPerformingDrivers(
    Emitter<TaxiOverviewState> emit,
  ) async {
    emit(state.copyWith(topEarningDriversState: ApiResponse.loading()));
    final topEarningDriversOrError = await _taxiOverviewRepository
        .getTopEarningDrivers(currency: state.currency!);
    emit(state.copyWith(topEarningDriversState: topEarningDriversOrError));
  }

  Future<void> _fetchTopSpendingCustomers(
    Emitter<TaxiOverviewState> emit,
  ) async {
    emit(state.copyWith(topSpendingCustomersState: ApiResponse.loading()));
    final topSpendingCustomersOrError = await _taxiOverviewRepository
        .getTopSpendingCustomers();
    emit(
      state.copyWith(topSpendingCustomersState: topSpendingCustomersOrError),
    );
  }

  @override
  Future<void> close() {
    _taxiOverviewRepository.stopSubscribingToDriverClusters();
    _taxiOverviewRepository.stopSubscribingToDriverLocations();
    return super.close();
  }
}
