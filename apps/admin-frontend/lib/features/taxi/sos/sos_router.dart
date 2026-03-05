import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class SosRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SosShellRoute.page,
      path: 'sos',
      children: [
        RedirectRoute(path: "", redirectTo: "list"),
        AutoRoute(page: SosListRoute.page, path: "list"),
        AutoRoute(page: SosReasonsRoute.page, path: "reasons"),
        AutoRoute(page: AddSosReasonRoute.page, path: "create"),
        AutoRoute(page: SosDetailRoute.page, path: "view/:sosDetail"),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) =>
      NavigationItem(
        title: context.tr.sos,
        value: SosShellRoute(),
        icon: (BetterIcons.megaphone03Outline, BetterIcons.megaphone03Filled),
      );
}
