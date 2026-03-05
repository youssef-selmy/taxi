import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class CustomerRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: CustomerShellRoute.page,
      path: "customer",
      children: [
        AutoRoute(page: CustomersRoute.page, path: "list", initial: true),
        AutoRoute(page: CreateCustomerRoute.page, path: "create"),
        AutoRoute(page: CustomerDetailsRoute.page, path: "view/:customerId"),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.customers,
        value: CustomerShellRoute(),
        icon: (BetterIcons.userMultipleOutline, BetterIcons.userMultipleFilled),
      );
}
