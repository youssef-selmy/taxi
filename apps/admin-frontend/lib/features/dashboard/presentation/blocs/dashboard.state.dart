part of 'dashboard.cubit.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState({
    PageRouteInfo? selectedRoute,
    @Default(false) bool isSidebarCollapsed,
  }) = _DashboardState;

  const DashboardState._();

  String? get activatedRouteName => selectedRoute?.routeName;
}
