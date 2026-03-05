import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class DriverRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: DriverShellRoute.page,
      path: 'driver',
      children: [
        AutoRoute(page: DriverListRoute.page, path: 'list'),
        AutoRoute(page: DriverDetailRoute.page, path: 'detail/:driverId'),
        AutoRoute(page: CreateNewDriverRoute.page, path: 'create'),
        AutoRoute(page: DriverSettingsRoute.page, path: 'settings'),
        AutoRoute(
          page: DriverPendingVerificationListRoute.page,
          path: 'pending-verification',
        ),
        AutoRoute(
          page: DriverPendingVerificationReviewRoute.page,
          path: 'pending-verification-review',
        ),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.drivers,
        value: const DriverShellRoute(),
        icon: (BetterIcons.taxiOutline, BetterIcons.taxiFilled),
        subItems: [
          NavigationSubItem(
            title: context.tr.viewAll,
            value: const DriverListRoute(),
          ),
          NavigationSubItem(
            title: context.tr.pendingVerification,
            value: const DriverPendingVerificationListRoute(),
          ),
          NavigationSubItem(
            title: context.tr.settings,
            value: DriverSettingsRoute(),
          ),
        ],
      );
}
