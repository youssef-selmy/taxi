import 'package:admin_frontend/features/customer/customer_router.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/accounting/accounting_router.dart';
import 'package:admin_frontend/features/management_common/management_common_router.dart';
import 'package:admin_frontend/features/marketing/marketing_router.dart';
import 'package:admin_frontend/features/payout/payout_router.dart';
import 'package:admin_frontend/features/settings/settings_router.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_router.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_management_router.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_router.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_router.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_router.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_router.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_router.dart';
import 'package:better_icons/better_icons.dart';

@AutoRouterConfig()
class ShopRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ShopShellRoute.page,
      path: 'shop',
      children: [
        AutoRoute(
          page: ShopOverviewRoute.page,
          path: 'overview',
          initial: true,
        ),
        AutoRoute(page: ShopDispatcherRoute.page, path: 'dispatcher'),
        ...ShopOrderRouter().routes,
        ...ShopReviewRouter().routes,
        ...ShopSupportRequestRouter().routes,
        ...VendorRouter().routes,
        ...ShopManagementRouter().routes,
        ...ShopAccountingRouter().routes,
        ...ShopPayoutSessionRouter().routes,
        ...ManagementCommonRouter().routes,
        ...CustomerRouter().routes,
        ...AccountingRouter().routes,
        ...MarketingRouter().routes,
      ],
    ),
  ];

  static List<NavigationItem<PageRouteInfo>> navigationItems(
    BuildContext context,
  ) {
    return [
      NavigationItem(
        title: context.tr.overview,
        value: ShopOverviewRoute(),
        icon: (
          BetterIcons.dashboardSquare02Outline,
          BetterIcons.dashboardSquare02Filled,
        ),
      ),
      NavigationItem(
        title: context.tr.dispatcher,
        value: ShopDispatcherRoute(),
        icon: (BetterIcons.rocketOutline, BetterIcons.rocket01Filled),
      ),
      ShopOrderRouter.navigationItem(context),
      ShopSupportRequestRouter.navigationItem(context),
      CustomerRouter.navigationItem(context),
      AccountingRouter.navigationItem(context, [
        ShopAccountingRouter.navigationItem(context),
      ]),
      PayoutRouter.navigationItem(context, [
        ShopPayoutSessionRouter.navigationItem(context),
      ]),
      VendorRouter.navigationItem(context),
      ShopReviewRouter.navigationItem(context),
      MarketingRouter.navigationItem(context),
      ManagementCommonRouter.navigationItem(
        context,
        ShopManagementRouter.navigationItems(context),
      ),
      SettingsRouter.navigationItem(context),
    ];
  }
}
