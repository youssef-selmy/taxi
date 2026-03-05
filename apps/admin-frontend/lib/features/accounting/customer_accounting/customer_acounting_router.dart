import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class CustomerAccountingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: CustomerAccountingShellRoute.page,
      path: 'customer',
      children: [
        AutoRoute(
          page: CustomerAccountingListRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(
          page: CustomerAccountingDetailRoute.page,
          path: 'detail/:customerId',
        ),
      ],
    ),
  ];
}
