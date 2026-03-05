import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class PlatformOverviewRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: PlatformOverviewShellRoute.page,
      path: "platform-overview",
      initial: true,
      children: [AutoRoute(page: PlatformOverviewRoute.page, initial: true)],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.overview,
        value: PlatformOverviewShellRoute(),
        icon: (
          BetterIcons.dashboardSquare02Outline,
          BetterIcons.dashboardSquare02Filled,
        ),
      );
}
