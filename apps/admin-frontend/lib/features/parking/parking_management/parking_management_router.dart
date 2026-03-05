import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_management/rating_points/parking_rating_points_router.dart';

@AutoRouterConfig()
class ParkingManagementRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkingManagementRoute.page,
      path: 'management',
      children: [...ParkingRatingPointsRouter().routes],
    ),
  ];

  static List<NavigationSubItem<PageRouteInfo>> navigationItems(
    BuildContext context,
  ) {
    return [
      NavigationSubItem(
        title: context.tr.ratingPoints,
        value: ParkingRatingPointsShellRoute(),
      ),
    ];
  }
}
