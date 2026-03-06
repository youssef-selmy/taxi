import 'package:auto_route/auto_route.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/sales_and_marketing/presentation/components/sales_and_marketing_dashboard_first/screens/sales_and_marketing_dashboard_first.desktop.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/sales_and_marketing_dashboard_analytics/screens/sales_and_marketing_dashboard_analytics_screen.desktop.dart';
import '../components/sales_and_marketing_dashboard_analytics/screens/sales_and_marketing_dashboard_analytics_screen.mobile.dart';
import '../components/sales_and_marketing_dashboard_first/screens/sales_and_marketing_dashboard_first.mobile.dart';
import '../components/sales_and_marketing_dashboard_overview/screens/sales_and_marketing_dashboard_overview_screen.desktop.dart';
import '../components/sales_and_marketing_dashboard_overview/screens/sales_and_marketing_dashboard_overview_screen.mobile.dart';
import '../components/sales_and_marketing_dashboard_refunds/screens/sales_and_marketing_dashboard_refunds_screen.desktop.dart';
import '../components/sales_and_marketing_dashboard_refunds/screens/sales_and_marketing_dashboard_refunds_screen.mobile.dart';
import '../components/sales_and_marketing_dashboard_sales/screens/sales_and_marketing_dashboard_sales_screen.desktop.dart';
import '../components/sales_and_marketing_dashboard_sales/screens/sales_and_marketing_dashboard_sales_screen.mobile.dart';
import '../components/sales_and_marketing_dashboard_sales_management_overview/screens/sales_and_marketing_dashboard_sales_management_overview_screen.desktop.dart';
import '../components/sales_and_marketing_dashboard_sales_management_overview/screens/sales_and_marketing_dashboard_sales_management_overview_screen.mobile.dart';
import '../components/sales_and_marketing_dashboard_sales_overview/screens/sales_and_marketing_dashboard_sales_overview_screen.desktop.dart';
import '../components/sales_and_marketing_dashboard_sales_overview/screens/sales_and_marketing_dashboard_sales_overview_screen.mobile.dart';
import '../components/sales_and_marketing_dashboard_waiting_list/screens/sales_and_marketing_dashboard_waiting_list_screen.desktop.dart';
import '../components/sales_and_marketing_dashboard_waiting_list/screens/sales_and_marketing_dashboard_waiting_list_screen.mobile.dart';

@RoutePage()
class SalesAndMarketingScreen extends StatelessWidget {
  const SalesAndMarketingScreen({super.key});
  static const double _maxHeight = 1000;
  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Templates',
            currentTitle: 'Sales & Marketing',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            icon: Assets.images.iconsTwotone.chart03.svg(
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                context.colors.onSuccess,
                BlendMode.srcIn,
              ),
            ),
            iconBackgroundColor: context.colors.success,
            iconColor: context.colors.onWarning,
            title: 'Sales & Marketing',
            description:
                'A complete sales and marketing template including multiple dashboard layouts for managing sales and marketing activities.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Dashboard First',
                desktopWidget: SalesAndMarketingDashboardFirstDesktop(),
                mobileWidget: SalesAndMarketingDashboardFirstMobile(),
                desktopSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_first.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_first.mobile.txt',

                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Sales Overview',
                desktopWidget:
                    SalesAndMarketingDashboardSalesOverviewScreenDesktop(),
                mobileWidget:
                    SalesAndMarketingDashboardSalesOverviewScreenMobile(),
                desktopSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_sales_overview.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_sales_overview.mobile.txt',
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Sales Management Overview',
                desktopWidget:
                    SalesAndMarketingDashboardSalesManagementOverviewScreenDesktop(),
                mobileWidget:
                    SalesAndMarketingDashboardSalesManagementOverviewScreenMobile(),
                desktopSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_sales_management_overview.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_sales_management_overview.mobile.txt',
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Waiting List',
                desktopWidget:
                    SalesAndMarketingDashboardWaitingListScreenDesktop(),
                mobileWidget:
                    SalesAndMarketingDashboardWaitingListScreenMobile(),
                desktopSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_waiting_list.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_waiting_list.mobile.txt',
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Overview',
                desktopWidget:
                    SalesAndMarketingDashboardOverviewScreenDesktop(),
                mobileWidget: SalesAndMarketingDashboardOverviewScreenMobile(),

                desktopSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_overview.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_overview.mobile.txt',
                fullScreenType: FullScreenType.dashboard,
              ),

              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Sales',
                desktopWidget: SalesAndMarketingDashboardSalesScreenDesktop(),
                mobileWidget: SalesAndMarketingDashboardSalesScreenMobile(),

                desktopSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_sales.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_sales.mobile.txt',
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Analytics',
                desktopWidget:
                    SalesAndMarketingDashboardAnalyticsScreenDesktop(),
                mobileWidget: SalesAndMarketingDashboardAnalyticsScreenMobile(),
                desktopSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_analytics.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_analytics.mobile.txt',
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                maxHeight: _maxHeight,
                title: 'Refunds',
                desktopWidget: SalesAndMarketingDashboardRefundsScreenDesktop(),
                mobileWidget: SalesAndMarketingDashboardRefundsScreenMobile(),
                desktopSourceCode:
                    'templates/sales_and_marketing/'
                    'sales_and_marketing_dashboard_refunds.desktop.txt',
                mobileSourceCode:
                    'templates/sales_and_marketing/sales_and_marketing_dashboard_refunds.mobile.txt',
                fullScreenType: FullScreenType.dashboard,
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
