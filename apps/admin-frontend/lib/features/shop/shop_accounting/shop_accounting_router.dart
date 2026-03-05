import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ShopAccountingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ShopAccountingShellRoute.page,
      path: 'shop',
      children: [
        AutoRoute(
          page: ShopAccountingListRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(page: ShopAccountingDetailRoute.page, path: 'detail/:shopId'),
      ],
    ),
  ];

  static NavigationSubItem<PageRouteInfo> navigationItem(
    BuildContext context,
  ) => NavigationSubItem(
    title: context.tr.shop,
    value: ShopAccountingShellRoute(),
  );
}
