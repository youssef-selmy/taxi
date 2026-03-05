import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ShopSupportRequestRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ShopSupportRequestShellRoute.page,
      path: 'shop-support-request',
      children: [
        AutoRoute(
          page: ShopSupportRequestListRoute.page,
          path: '',
          initial: true,
        ),
        AutoRoute(
          page: ShopSupportRequestDetailRoute.page,
          path: 'detail/:supportRequestId',
        ),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.support,
        value: ShopSupportRequestShellRoute(),
        icon: (BetterIcons.headphonesOutline, BetterIcons.headphonesFilled),
      );
}
