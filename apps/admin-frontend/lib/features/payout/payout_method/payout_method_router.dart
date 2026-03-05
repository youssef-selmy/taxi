import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class PayoutMethodRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: PayoutMethodShellRoute.page,
      path: 'payout-method',
      children: [
        AutoRoute(
          page: PayoutMethodListRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(
          page: PayoutMethodDetailRoute.page,
          path: 'detail/:payoutMethodId',
        ),
      ],
    ),
  ];
}
