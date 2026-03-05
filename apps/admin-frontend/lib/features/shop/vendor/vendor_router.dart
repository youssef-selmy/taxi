import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class VendorRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: VendorShellRoute.page,
      path: 'vendor',
      children: [
        AutoRoute(page: VendorListRoute.page, path: 'list', initial: true),
        AutoRoute(
          page: VendorListPendingVerificationRoute.page,
          path: 'pending-verification',
        ),
        AutoRoute(page: VendorCreateRoute.page, path: 'create'),
        AutoRoute(page: ShopDetailRoute.page, path: 'detail/:shopId'),
        AutoRoute(page: ShopSettingsRoute.page, path: 'detail/:shopId'),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) {
    return NavigationItem(
      title: context.tr.shops,
      value: VendorShellRoute(),
      icon: (BetterIcons.store01Outline, BetterIcons.store01Filled),
      subItems: [
        NavigationSubItem(
          title: context.tr.pendingVerification,
          value: VendorListPendingVerificationRoute(),
        ),
        NavigationSubItem(title: context.tr.viewAll, value: VendorListRoute()),
        NavigationSubItem(
          title: context.tr.settings,
          value: ShopSettingsRoute(),
        ),
      ],
    );
  }
}
