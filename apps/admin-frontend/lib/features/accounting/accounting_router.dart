import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_router.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_acounting_router.dart';

@AutoRouterConfig()
class AccountingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AccountingShellRoute.page,
      path: 'accounting',
      children: [
        ...AdminAccountingRouter().routes,
        ...CustomerAccountingRouter().routes,
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(
    BuildContext context,
    List<NavigationSubItem<PageRouteInfo>> additionalItems,
  ) => NavigationItem(
    title: context.tr.accounting,
    value: AccountingShellRoute(),
    icon: (BetterIcons.analytics01Outline, BetterIcons.analytics01Filled),
    subItems: [
      NavigationSubItem(
        title: context.tr.admin,
        value: AdminAccountingShellRoute(),
      ),
      NavigationSubItem(
        title: context.tr.customer,
        value: CustomerAccountingShellRoute(),
      ),
      ...additionalItems,
    ],
  );
}
