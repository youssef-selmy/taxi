import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

class FleetRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: FleetShellRoute.page,
      path: 'fleets',
      children: [
        AutoRoute(page: FleetListRoute.page, path: "list", initial: true),
        AutoRoute(page: AddFleetRoute.page, path: "create"),
        AutoRoute(page: FleetAccountDetailRoute.page, path: "view/:fleetId"),
        AutoRoute(page: FleetStaffDetailRoute.page, path: "view/:fleetStaffId"),
        AutoRoute(page: AddFleetStaffRoute.page, path: ":fleetID/add-staff"),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) {
    return NavigationItem(
      title: context.tr.fleets,
      value: FleetShellRoute(),
      icon: (BetterIcons.building02Outline, BetterIcons.building02Filled),
    );
  }
}
