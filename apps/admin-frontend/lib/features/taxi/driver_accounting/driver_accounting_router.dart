import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class DriverAccountingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: DriverAccountingShellRoute.page,
      path: 'driver',
      children: [
        AutoRoute(
          page: DriverAccountingListRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(
          page: DriverAccountingDetailRoute.page,
          path: 'detail/:driverid',
        ),
      ],
    ),
  ];

  static NavigationSubItem<PageRouteInfo> navigationItem(
    BuildContext context,
  ) => NavigationSubItem(
    title: context.tr.driver,
    value: DriverAccountingShellRoute(),
  );
}
