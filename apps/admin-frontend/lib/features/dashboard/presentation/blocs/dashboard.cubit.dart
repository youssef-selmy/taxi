import 'package:admin_frontend/core/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'dashboard.state.dart';
part 'dashboard.cubit.freezed.dart';

@lazySingleton
class DashboardBloc extends Cubit<DashboardState> {
  DashboardBloc() : super(const DashboardState());

  void onStarted() {
    emit(state.copyWith(selectedRoute: TaxiOverviewRoute()));
  }

  void goToRoute(PageRouteInfo? route) {
    // final index = tabRoutes.indexWhere((e) => e.routeName == route.routeName);
    emit(state.copyWith(selectedRoute: route));
  }

  void setIsSidebarCollapsed(bool isCollapsed) {
    emit(state.copyWith(isSidebarCollapsed: isCollapsed));
  }
}
