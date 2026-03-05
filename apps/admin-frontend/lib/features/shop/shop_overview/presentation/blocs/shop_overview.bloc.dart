import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/shop/shop_overview/data/graphql/shop_overview.graphql.dart';
import 'package:admin_frontend/features/shop/shop_overview/data/repositories/shop_overview_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'shop_overview.state.dart';
part 'shop_overview.bloc.freezed.dart';

class ShopOverviewBloc extends Cubit<ShopOverviewState> {
  final ShopOverviewRepository _shopOverviewRepository =
      locator<ShopOverviewRepository>();

  ShopOverviewBloc() : super(ShopOverviewState());

  void onStarted({required String currency}) {
    emit(state.copyWith(currency: currency));
    _fetchAll();
  }

  void _fetchAll() {
    _fetchKPIs();
    _fetchActiveOrders();
    _fetchPendingShops();
    _fetchPendingSupportRequests();
    _fetchTopPerformingShops();
    _fetchTopSpendingCustomers();
  }

  void _fetchKPIs() async {
    emit(state.copyWith(kpisState: ApiResponse.loading()));
    final kpisOrError = await _shopOverviewRepository.getKPIs(
      currency: state.currency!,
    );
    final kpisState = kpisOrError;
    emit(state.copyWith(kpisState: kpisState));
  }

  void _fetchActiveOrders() async {
    emit(state.copyWith(activeOrdersState: ApiResponse.loading()));
    final activeOrdersOrError = await _shopOverviewRepository.getActiveOrders(
      currency: state.currency!,
    );
    final activeOrdersState = activeOrdersOrError;
    emit(state.copyWith(activeOrdersState: activeOrdersState));
  }

  void _fetchPendingShops() async {
    emit(state.copyWith(pendingShopsState: ApiResponse.loading()));
    final pendingShopsOrError = await _shopOverviewRepository.getPendingShops();
    final pendingShopsState = pendingShopsOrError;
    emit(state.copyWith(pendingShopsState: pendingShopsState));
  }

  void _fetchPendingSupportRequests() async {
    emit(state.copyWith(pendingSupportRequestsState: ApiResponse.loading()));
    final pendingSupportRequestsOrError = await _shopOverviewRepository
        .getPendingSupportRequets();
    final pendingSupportRequestsState = pendingSupportRequestsOrError;
    emit(
      state.copyWith(pendingSupportRequestsState: pendingSupportRequestsState),
    );
  }

  void _fetchTopPerformingShops() async {
    emit(state.copyWith(topEarningShopsState: ApiResponse.loading()));
    final topEarningShopsOrError = await _shopOverviewRepository
        .getTopEarningShops();
    final topEarningShopsState = topEarningShopsOrError;
    emit(state.copyWith(topEarningShopsState: topEarningShopsState));
  }

  void _fetchTopSpendingCustomers() async {
    emit(state.copyWith(topSpendingCustomersState: ApiResponse.loading()));
    final topSpendingCustomersOrError = await _shopOverviewRepository
        .getTopSpendingCustomers();
    final topSpendingCustomersState = topSpendingCustomersOrError;
    emit(state.copyWith(topSpendingCustomersState: topSpendingCustomersState));
  }

  void onCurrencyChanged(String currency) {
    emit(state.copyWith(currency: currency));
    _fetchKPIs();
    _fetchActiveOrders();
  }

  void onActiveOrdersPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(activeOrdersPaging: p1));
    _fetchActiveOrders();
  }
}
