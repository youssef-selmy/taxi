import 'package:admin_frontend/features/accounting/accounting_router.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/app_switcher_v2.dart';
import 'package:admin_frontend/features/platform_overview/platform_overview_router.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_router.dart';
import 'package:admin_frontend/features/dashboard/presentation/blocs/dashboard.cubit.dart';
import 'package:admin_frontend/features/management_common/management_common_router.dart';
import 'package:admin_frontend/features/marketing/marketing_router.dart';
import 'package:admin_frontend/features/parking/parking_router.dart';
import 'package:admin_frontend/features/settings/settings_router.dart';
import 'package:admin_frontend/features/shop/shop_router.dart';
import 'package:admin_frontend/features/taxi/taxi_router.dart';
import 'package:admin_frontend/schema.graphql.dart';

List<NavigationItem<PageRouteInfo>> navigationItemsFor(
  BuildContext context,
  Enum$AppType? appType,
) => switch (appType) {
  null => [
    PlatformOverviewRouter.navigationItem(context),
    CustomerRouter.navigationItem(context),
    MarketingRouter.navigationItem(context),
    AccountingRouter.navigationItem(context, []),
    ManagementCommonRouter.navigationItem(context, []),
    SettingsRouter.navigationItem(context),
  ],
  Enum$AppType.Taxi => TaxiRouter.navigationItems(context),
  Enum$AppType.Shop => ShopRouter.navigationItems(context),
  Enum$AppType.Parking => ParkingRouter.navigationItems(context),
  Enum$AppType.$unknown => throw Exception('Unknown app type'),
};

class DrawerDesktop extends StatelessWidget {
  const DrawerDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<ConfigBloc>()),
        BlocProvider.value(value: locator<AuthBloc>()),
      ],
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, dashboardState) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Align(
                alignment: Alignment.topLeft,
                child: AppSidebarNavigation<PageRouteInfo?>(
                  expandedWidth: 270,
                  collapsedWidth: 153,
                  collapsable: true,
                  onCollapseChanged: (isCollapsed) {
                    context.read<DashboardBloc>().setIsSidebarCollapsed(
                      isCollapsed,
                    );
                  },
                  header: AppSwitcherV2(
                    isCollapsed: dashboardState.isSidebarCollapsed,
                  ),
                  selectedItem: dashboardState.selectedRoute,
                  onItemSelected: (item) {
                    context.read<DashboardBloc>().goToRoute(item);
                    context.router.replaceAll([
                      item!,
                    ], updateExistingRoutes: true);
                  },
                  data: navigationItemsFor(context, authState.selectedAppType),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
