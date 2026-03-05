import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class AdminAccountingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AdminAccountingShellRoute.page,
      path: 'admin',
      children: [
        AutoRoute(
          page: AdminAccountingDashboardRoute.page,
          path: 'dashboard',
          initial: true,
        ),
      ],
    ),
  ];
}
