import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ParkingAccountingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkingAccountingShellRoute.page,
      path: 'parking',
      children: [
        AutoRoute(
          page: ParkingAccountingListRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(
          page: ParkingAccountingDetailRoute.page,
          path: 'detail/:parkingId',
        ),
      ],
    ),
  ];

  static NavigationSubItem<PageRouteInfo> navigationItem(
    BuildContext context,
  ) => NavigationSubItem(
    title: context.tr.parking,
    value: ParkingAccountingShellRoute(),
  );
}
