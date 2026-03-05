import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_router.dart';

@AutoRouterConfig()
class PayoutRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: PayoutShellRoute.page,
      path: 'payout',
      children: [...PayoutMethodRouter().routes],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(
    BuildContext context,
    List<NavigationSubItem<PageRouteInfo>> additionalItems,
  ) => NavigationItem(
    title: context.tr.payout,
    value: PayoutShellRoute(),
    icon: (BetterIcons.money03Outline, BetterIcons.money03Filled),
    subItems: [
      NavigationSubItem(
        title: context.tr.payoutMethods,
        value: PayoutMethodShellRoute(),
      ),
      ...additionalItems,
    ],
  );
}
