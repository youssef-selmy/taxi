import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ShopPayoutSessionRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ShopPayoutSessionShellRoute.page,
      path: 'shop-payout-session',
      children: [
        AutoRoute(
          page: ShopPayoutSessionListRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(page: ShopPayoutSessionDetailRoute.page, path: 'detail/:id'),
      ],
    ),
  ];

  static NavigationSubItem<PageRouteInfo> navigationItem(
    BuildContext context,
  ) => NavigationSubItem(
    title: context.tr.shopPayout,
    value: ShopPayoutSessionShellRoute(),
  );
}
