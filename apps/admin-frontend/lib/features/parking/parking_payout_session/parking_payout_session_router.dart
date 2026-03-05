import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ParkingPayoutSessionRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkingPayoutSessionShellRoute.page,
      path: 'parking-payout-session',
      children: [
        AutoRoute(
          page: ParkingPayoutSessionListRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(
          page: ParkingPayoutSessionDetailRoute.page,
          path: 'detail/:id',
        ),
      ],
    ),
  ];

  static NavigationSubItem<PageRouteInfo> navigationItem(
    BuildContext context,
  ) => NavigationSubItem(
    title: context.tr.parkingPayout,
    value: ParkingPayoutSessionShellRoute(),
  );
}
