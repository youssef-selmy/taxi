import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ParkingOrderRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkingOrderShellRoute.page,
      path: 'parking-order',
      children: [
        AutoRoute(page: ParkingOrderListRoute.page, path: '', initial: true),
        AutoRoute(
          page: ParkingOrderDetailRoute.page,
          path: 'detail/:parkingOrderId',
        ),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.orders,
        value: const ParkingOrderShellRoute(),
        icon: (BetterIcons.bookOpen01Outline, BetterIcons.bookOpen01Filled),
      );
}
