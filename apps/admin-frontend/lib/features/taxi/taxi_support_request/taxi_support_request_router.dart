import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class TaxiSupportRequestRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: TaxiSupportRequestShellRoute.page,
      path: 'taxi-support-request',
      children: [
        AutoRoute(
          page: TaxiSupportRequestListRoute.page,
          path: '',
          initial: true,
        ),
        AutoRoute(
          page: TaxiSupportRequestDetailRoute.page,
          path: 'detail/:supportRequestId',
        ),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.support,
        value: TaxiSupportRequestShellRoute(),
        icon: (BetterIcons.headphonesOutline, BetterIcons.headphonesFilled),
      );
}
