import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_categories_router.dart';

@AutoRouterConfig()
class ShopManagementRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ShopManagementShellRoute.page,
      path: 'management-shop',
      children: [...ShopCategoriesRouter().routes],
    ),
  ];

  static List<NavigationSubItem<PageRouteInfo>> navigationItems(
    BuildContext context,
  ) {
    return [
      NavigationSubItem(
        title: context.tr.shopCategories,
        value: ShopCategoriesShellRoute(),
      ),
    ];
  }
}
