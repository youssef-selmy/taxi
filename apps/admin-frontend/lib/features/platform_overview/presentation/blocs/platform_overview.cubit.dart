import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/taxi_order_repository.dart';
import 'package:admin_frontend/features/platform_overview/data/graphql/platform_overview.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/platform_overview/domain/repositories/platform_overview_repository.dart';

part 'platform_overview.state.dart';
part 'platform_overview.cubit.freezed.dart';

@lazySingleton
class PlatformOverviewCubit extends Cubit<PlatformOverviewState> {
  final PlatformOverviewRepository _platformOverviewRepository =
      locator<PlatformOverviewRepository>();
  final TaxiOrderRepository _taxiOrderRepository =
      locator<TaxiOrderRepository>();

  PlatformOverviewCubit() : super(PlatformOverviewState.initial());

  void onStarted() {
    _fetchPendingSupportRequests();
    _fetchPendingOrders();
    _fetchOverviewKPIs();
    _fetchOrderVolumeTimeSeries();
    _fetchTaxiOrders();
  }

  void onCurrencyChanged(String currency) {
    emit(state.copyWith(currency: currency));
    _fetchOverviewKPIs();
  }

  Future<void> _fetchPendingSupportRequests() async {
    emit(state.copyWith(pendingSupportRequests: ApiResponse.loading()));

    final pendingSupportRequestsOrError = await _platformOverviewRepository
        .getpendingSupportRequestsCount();

    emit(state.copyWith(pendingSupportRequests: pendingSupportRequestsOrError));
  }

  Future<void> _fetchPendingOrders() async {
    emit(state.copyWith(pendingOrders: ApiResponse.loading()));

    final pendingOrdersOrError = await _platformOverviewRepository
        .getPendingOrders();

    emit(state.copyWith(pendingOrders: pendingOrdersOrError));
  }

  Future<void> _fetchOverviewKPIs() async {
    emit(state.copyWith(overviewKPIs: ApiResponse.loading()));

    final overviewKPIsOrError = await _platformOverviewRepository
        .getOverviewKPIs(currency: state.currency, period: state.period);

    emit(state.copyWith(overviewKPIs: overviewKPIsOrError));
  }

  Future<void> _fetchOrderVolumeTimeSeries() async {
    emit(state.copyWith(orderVolumeTimeSeries: ApiResponse.loading()));

    final orderVolumeTimeSeriesOrError = await _platformOverviewRepository
        .getOrderVolumeTimeSeries(period: state.period);

    emit(state.copyWith(orderVolumeTimeSeries: orderVolumeTimeSeriesOrError));
  }

  Future<void> _fetchTaxiOrders() async {
    emit(state.copyWith(taxiOrders: ApiResponse.loading()));

    final ordersOrError = await _taxiOrderRepository.getAll(
      filter: Input$TaxiOrderFilterInput(status: [Enum$TaxiOrderStatus.OnTrip]),
      paging: state.taxiOrdersPaging,
      sorting: state.taxiSortFields,
    );

    emit(state.copyWith(taxiOrders: ordersOrError));
  }

  Future<void> fetchShopOrders() async {
    emit(state.copyWith(shopOrders: ApiResponse.loading()));

    final shopOrdersOrError = await _platformOverviewRepository.getShopOrders(
      filter: Input$ShopOrderFilter(createdAt: Input$DateFieldComparison()),
      paging: state.shopOrdersPaging,
      sorting: state.shopSortFields,
    );

    emit(state.copyWith(shopOrders: shopOrdersOrError));
  }

  Future<void> fetchParkingOrders() async {
    emit(state.copyWith(parkingOrders: ApiResponse.loading()));

    final parkingOrdersOrError = await _platformOverviewRepository
        .getParkingOrders(
          filter: Input$ParkOrderFilter(),
          paging: state.parkingOrdersPaging,
          sorting: state.parkingSortFields,
        );

    emit(state.copyWith(parkingOrders: parkingOrdersOrError));
  }

  void onTaxiOrdersPageChanged(Input$OffsetPaging paging) {
    emit(
      state.copyWith(
        taxiOrdersPaging: Input$PaginationInput(
          first: paging.limit,
          after: paging.offset,
        ),
      ),
    );
    _fetchTaxiOrders();
  }

  void onShopOrdersPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(shopOrdersPaging: paging));
    fetchShopOrders();
  }

  void onParkingOrdersPageChanged(Input$OffsetPaging paging) {
    emit(state.copyWith(parkingOrdersPaging: paging));
    fetchParkingOrders();
  }

  void onTaxiSortingChanged(Input$TaxiOrderSortInput value) {
    emit(state.copyWith(taxiSortFields: value));
    _fetchTaxiOrders();
  }

  void onSelectedCategoryChanged(Enum$AppType value) {
    emit(state.copyWith(selectedCategory: value));
  }

  void onChangedPeriod(Enum$KPIPeriod period) {
    emit(state.copyWith(period: period));
    _fetchOverviewKPIs();
    _fetchOrderVolumeTimeSeries();
  }

  void onShopSortingChanged(List<Input$ShopOrderSort> value) {
    emit(state.copyWith(shopSortFields: value));
    fetchShopOrders();
  }

  void onParkingSortingChanged(List<Input$ParkOrderSort> value) {
    emit(state.copyWith(parkingSortFields: value));
    fetchParkingOrders();
  }
}
