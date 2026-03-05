import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ParkingReviewRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkingReviewShellRoute.page,
      path: 'parking-review',
      children: [
        AutoRoute(page: ParkingReviewListRoute.page, path: '', initial: true),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.reviews,
        value: const ParkingReviewShellRoute(),
        icon: (BetterIcons.chatting01Outline, BetterIcons.chatting01Filled),
      );
}
