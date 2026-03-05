import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class TaxiOrderRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: TaxiOrderShellRoute.page,
      path: 'taxi_order',
      children: [
        AutoRoute(page: TaxiOrderListRoute.page, path: '', initial: true),
        AutoRoute(page: TaxiOrderArchiveListRoute.page, path: 'archive'),
        AutoRoute(page: TaxiOrderDetailRoute.page, path: 'detail/:orderId'),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.orders,
        value: const TaxiOrderShellRoute(),
        icon: (BetterIcons.bookOpen01Outline, BetterIcons.bookOpen01Filled),
      );
}
