import 'package:admin_frontend/features/customer/customer_router.dart';
import 'package:admin_frontend/features/marketing/marketing_router.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/accounting/accounting_router.dart';
import 'package:admin_frontend/features/management_common/management_common_router.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_router.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_router.dart';
import 'package:admin_frontend/features/parking/parking_management/parking_management_router.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_router.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_router.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_router.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_router.dart';
import 'package:admin_frontend/features/payout/payout_router.dart';
import 'package:admin_frontend/features/settings/settings_router.dart';

@AutoRouterConfig()
class ParkingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkingShellRoute.page,
      path: 'parking',
      children: [
        AutoRoute(
          page: ParkingOverviewRoute.page,
          path: 'overview',
          initial: true,
        ),
        AutoRoute(page: ParkingDispatcherRoute.page, path: 'dispatcher'),
        ...ParkingOrderRouter().routes,
        ...ParkingReviewRouter().routes,
        ...ParkingSupportRequestRouter().routes,
        ...ParkSpotRouter().routes,
        ...ParkingAccountingRouter().routes,
        ...ParkingManagementRouter().routes,
        ...ParkingPayoutSessionRouter().routes,
        ...ManagementCommonRouter().routes,
        ...CustomerRouter().routes,
        ...AccountingRouter().routes,
        ...MarketingRouter().routes,
      ],
    ),
  ];

  static List<NavigationItem<PageRouteInfo>> navigationItems(
    BuildContext context,
  ) => [
    NavigationItem(
      title: context.tr.overview,
      value: const ParkingOverviewRoute(),
      icon: (
        BetterIcons.dashboardSquare02Outline,
        BetterIcons.dashboardSquare02Filled,
      ),
    ),
    NavigationItem(
      title: context.tr.dispatcher,
      value: const ParkingDispatcherRoute(),
      icon: (BetterIcons.rocketOutline, BetterIcons.rocketFilled),
    ),
    ParkingOrderRouter.navigationItem(context),
    CustomerRouter.navigationItem(context),
    ParkingSupportRequestRouter.navigationItem(context),
    AccountingRouter.navigationItem(context, [
      ParkingAccountingRouter.navigationItem(context),
    ]),
    PayoutRouter.navigationItem(context, [
      ParkingPayoutSessionRouter.navigationItem(context),
    ]),
    ParkSpotRouter.navigationItem(context),
    ParkingReviewRouter.navigationItem(context),
    ManagementCommonRouter.navigationItem(
      context,
      ParkingManagementRouter.navigationItems(context),
    ),
    SettingsRouter.navigationItem(context),
  ];
}
