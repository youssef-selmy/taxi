import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ParkSpotRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkSpotShellRoute.page,
      path: 'park-spot',
      children: [
        AutoRoute(initial: true, page: ParkSpotListRoute.page, path: 'list'),
        AutoRoute(
          page: ParkSpotPendingVerificationListRoute.page,
          path: 'pending-verification-list',
        ),
        AutoRoute(page: ParkSpotCreateRoute.page, path: 'create'),
        AutoRoute(page: ParkSpotDetailRoute.page, path: "detail/:parkSpotId"),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) {
    return NavigationItem(
      title: context.tr.parking,
      value: ParkingShellRoute(),
      icon: (BetterIcons.carParking01Outline, BetterIcons.carParking01Filled),
      subItems: [
        NavigationSubItem(
          title: context.tr.viewAll,
          value: ParkSpotListRoute(),
        ),
        NavigationSubItem(
          title: context.tr.pendingVerification,
          value: ParkSpotPendingVerificationListRoute(),
        ),
      ],
    );
  }
}
