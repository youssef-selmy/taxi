import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/parking_overview/data/graphql/parking_overview.graphql.dart';
import 'package:admin_frontend/features/parking/parking_overview/data/repositories/parking_overview_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'parking_overview.state.dart';
part 'parking_overview.bloc.freezed.dart';

class ParkingOverviewBloc extends Cubit<ParkingOverviewState> {
  final ParkingOverviewRepository _parkingOverviewRepository =
      locator<ParkingOverviewRepository>();

  ParkingOverviewBloc() : super(ParkingOverviewState());

  void onStarted({required String currency}) {
    emit(state.copyWith(currency: currency));
    _fetchAll();
  }

  void _fetchAll() {
    _fetchKPIs();
    _fetchActiveOrders();
    _fetchPendingParkings();
    _fetchPendingSupportRequests();
    _fetchTopPerformingParkings();
    _fetchTopSpendingCustomers();
  }

  void _fetchKPIs() async {
    emit(state.copyWith(kpisState: ApiResponse.loading()));
    final kpisOrError = await _parkingOverviewRepository.getKPIs(
      currency: state.currency!,
    );
    final kpisState = kpisOrError;
    emit(state.copyWith(kpisState: kpisState));
  }

  void _fetchActiveOrders() async {
    emit(state.copyWith(activeOrdersState: ApiResponse.loading()));
    final activeOrdersOrError = await _parkingOverviewRepository
        .getActiveOrders(currency: state.currency!);
    final activeOrdersState = activeOrdersOrError;
    emit(state.copyWith(activeOrdersState: activeOrdersState));
  }

  void _fetchPendingParkings() async {
    emit(state.copyWith(pendingParkingsState: ApiResponse.loading()));
    final pendingParkingsOrError = await _parkingOverviewRepository
        .getPendingParkings();
    final pendingParkingsState = pendingParkingsOrError;
    emit(state.copyWith(pendingParkingsState: pendingParkingsState));
  }

  void _fetchPendingSupportRequests() async {
    emit(state.copyWith(pendingSupportRequestsState: ApiResponse.loading()));
    final pendingSupportRequestsOrError = await _parkingOverviewRepository
        .getPendingSupportRequets();
    final pendingSupportRequestsState = pendingSupportRequestsOrError;
    emit(
      state.copyWith(pendingSupportRequestsState: pendingSupportRequestsState),
    );
  }

  void _fetchTopPerformingParkings() async {
    emit(state.copyWith(topEarningParkingsState: ApiResponse.loading()));
    final topEarningParkingsOrError = await _parkingOverviewRepository
        .getTopEarningParkings(currency: state.currency!);
    final topEarningParkingsState = topEarningParkingsOrError;
    emit(state.copyWith(topEarningParkingsState: topEarningParkingsState));
  }

  void _fetchTopSpendingCustomers() async {
    emit(state.copyWith(topSpendingCustomersState: ApiResponse.loading()));
    final topSpendingCustomersOrError = await _parkingOverviewRepository
        .getTopSpendingCustomers();
    final topSpendingCustomersState = topSpendingCustomersOrError;
    emit(state.copyWith(topSpendingCustomersState: topSpendingCustomersState));
  }

  void onCurrencyChanged(String currency) {
    emit(state.copyWith(currency: currency));
    _fetchKPIs();
    _fetchActiveOrders();
    _fetchTopPerformingParkings();
  }

  void onActiveOrdersPageChanged(Input$OffsetPaging p1) {
    emit(state.copyWith(activeOrdersPaging: p1));
    _fetchActiveOrders();
  }
}
