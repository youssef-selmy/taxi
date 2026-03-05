import 'package:admin_frontend/features/payout/payout_router.dart';
import 'package:admin_frontend/features/settings/settings_router.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/accounting/accounting_router.dart';
import 'package:admin_frontend/features/customer/customer_router.dart';
import 'package:admin_frontend/features/management_common/management_common_router.dart';
import 'package:admin_frontend/features/marketing/marketing_router.dart';
import 'package:admin_frontend/features/taxi/driver/driver_router.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_router.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_router.dart';
import 'package:admin_frontend/features/taxi/fleet/fleet_router.dart';
import 'package:admin_frontend/features/taxi/sos/sos_router.dart';
import 'package:admin_frontend/features/taxi/taxi_management/taxi_management_router.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_router.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_router.dart';

@AutoRouterConfig()
class TaxiRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: TaxiShellRoute.page,
      path: 'taxi',
      children: [
        AutoRoute(
          page: TaxiOverviewRoute.page,
          path: 'overview',
          initial: true,
        ),
        AutoRoute(page: DispatcherTaxiRoute.page, path: 'dispatcher'),
        ...TaxiOrderRouter().routes,
        ...DriverRouter().routes,
        ...TaxiSupportRequestRouter().routes,
        ...DriverPayoutSessionRouter().routes,
        ...DriverAccountingRouter().routes,
        ...SosRouter().routes,
        ...FleetRouter().routes,
        ...TaxiManagementRouter().routes,
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
      value: const TaxiOverviewRoute(),
      icon: (
        BetterIcons.dashboardSquare02Outline,
        BetterIcons.dashboardSquare02Filled,
      ),
    ),
    NavigationItem(
      title: context.tr.dispatcher,
      value: const DispatcherTaxiRoute(),
      icon: (BetterIcons.rocketOutline, BetterIcons.rocketFilled),
    ),
    DriverRouter.navigationItem(context),
    TaxiOrderRouter.navigationItem(context),
    CustomerRouter.navigationItem(context),
    MarketingRouter.navigationItem(context),
    PayoutRouter.navigationItem(context, [
      DriverPayoutSessionRouter.navigationItem(context),
    ]),
    AccountingRouter.navigationItem(context, [
      DriverAccountingRouter.navigationItem(context),
    ]),
    SosRouter.navigationItem(context),
    TaxiSupportRequestRouter.navigationItem(context),
    FleetRouter.navigationItem(context),
    ManagementCommonRouter.navigationItem(
      context,
      TaxiManagementRouter.navigationItems(context),
    ),
    SettingsRouter.navigationItem(context),
  ];
}
