import 'dart:core';

import 'package:admin_frontend/features/platform_overview/platform_overview_router.dart';
import 'package:admin_frontend/features/platform_overview/platform_overview_shell_screen.dart';
import 'package:admin_frontend/features/platform_overview/presentation/screens/platform_overview_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_dispatch/presentation/screens/settings_dispatch_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_map/presentation/screens/settings_map_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_subscription/presentation/screens/settings_subscription_screen.dart';
import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/screens/shop_settings_screen.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/screens/taxi_order_detail_screen.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/screens/taxi_order_archive_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/router/app_router.parking.dart';
import 'package:admin_frontend/core/router/app_router.shop.dart';
import 'package:admin_frontend/core/router/app_router.taxi.dart';
import 'package:admin_frontend/core/router/guards/config/disable_config_guard.dart';
import 'package:admin_frontend/core/router/guards/dashboard/config_guard.dart';
import 'package:admin_frontend/core/router/guards/dashboard/login_guard.dart';
import 'package:admin_frontend/features/accounting/accounting_router.dart';
import 'package:admin_frontend/features/accounting/accounting_shell_screen.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/screens/admin_accounting_dashboard_screen.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_shell_screen.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/screens/customer_accounting_detail_screen.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/presentation/screens/customer_accounting_list_screen.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_shell_screen.dart';
import 'package:admin_frontend/features/auth/presentation/screens/auth_page.dart';
import 'package:admin_frontend/features/auth/presentation/screens/auth_router_page.dart';
import 'package:admin_frontend/features/auth/presentation/screens/license_information_page.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/config_error_state_screen.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/configurer_screen.dart';
import 'package:admin_frontend/features/customer/create_customer/presentation/screens/create_customer_screen.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/customer_details_screen.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/screens/customers_screen.dart';
import 'package:admin_frontend/features/customer/customer_router.dart';
import 'package:admin_frontend/features/customer/customer_shell_screen.dart';
import 'package:admin_frontend/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:admin_frontend/features/dashboard/presentation/screens/initial_empty_screen.dart';
import 'package:admin_frontend/features/login/presentation/screens/login_screen.dart';
import 'package:admin_frontend/features/management_common/management_common_router.dart';
import 'package:admin_frontend/features/management_common/management_common_screen.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/payment_gateway_parent_screen.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/presentation/screens/details/payment_gateway_details_screen.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/presentation/screens/list/payment_gateways_list_screen.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/screens/region_category_details/region_category_details_screen.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/screens/region_details/region_details_screen.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/screens/regions_list/regions_list_screen.dart';
import 'package:admin_frontend/features/management_common/regions/regions_shell_screen.dart';
import 'package:admin_frontend/features/management_common/sms_provider/presentation/screens/details/sms_provider_details_screen.dart';
import 'package:admin_frontend/features/management_common/sms_provider/presentation/screens/list/sms_provider_list_screen.dart';
import 'package:admin_frontend/features/management_common/sms_provider/sms_provider_parent_screen.dart';
import 'package:admin_frontend/features/management_common/email_provider/email_provider_parent_screen.dart';
import 'package:admin_frontend/features/management_common/email_provider/presentation/screens/details/email_provider_details_screen.dart';
import 'package:admin_frontend/features/management_common/email_provider/presentation/screens/list/email_provider_list_screen.dart';
import 'package:admin_frontend/features/management_common/email_template/email_template_parent_screen.dart';
import 'package:admin_frontend/features/management_common/email_template/presentation/screens/details/email_template_details_screen.dart';
import 'package:admin_frontend/features/management_common/email_template/presentation/screens/list/email_template_list_screen.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/screens/add_staff_screen.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/screens/staff_detail_screen.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/screens/staff_list_screen.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/screens/staff_role_detail_screen.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/screens/staff_role_list_screen.dart';
import 'package:admin_frontend/features/management_common/staff/staff_parrent_screen.dart';
import 'package:admin_frontend/features/marketing/announcement/announcement_shell_screen.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/screens/announcement_list_screen.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/screens/create/create_announcement_screen.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/screens/details/announcement_detail_screen.dart';
import 'package:admin_frontend/features/marketing/coupon/coupon_shell_screen.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/screens/campaign_details_screen.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/screens/campaign_list_screen.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/screens/create_campaign/create_campaign_screen.dart';
import 'package:admin_frontend/features/marketing/gift_card/gift_card_shell_screen.dart';
import 'package:admin_frontend/features/marketing/gift_card/presentation/screens/create_gift_batch_screen.dart';
import 'package:admin_frontend/features/marketing/gift_card/presentation/screens/gift_card_details_screen.dart';
import 'package:admin_frontend/features/marketing/gift_card/presentation/screens/gift_card_list_screen.dart';
import 'package:admin_frontend/features/marketing/marketing_router.dart';
import 'package:admin_frontend/features/marketing/marketing_shell_screen.dart';
import 'package:admin_frontend/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_detail/presentation/screens/payout_method_detail_screen.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/presentation/screens/payout_method_list_screen.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_shell_screen.dart';
import 'package:admin_frontend/features/payout/payout_router.dart';
import 'package:admin_frontend/features/payout/payout_shell_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_appearance/presentation/screens/settings_appearance_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_branding/presentation/screens/settings_branding_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_general/presentation/screens/settings_general_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_notification/presentation/screens/settings_notification_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_password/presentation/screens/settings_password_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/presentation/screens/settings_sessions_screen.dart';
import 'package:admin_frontend/features/settings/features/settings_system/presentation/screens/settings_system_screen.dart';
import 'package:admin_frontend/features/settings/presentation/screens/settings_shell_screen.dart';
import 'package:admin_frontend/features/settings/settings_router.dart';

part 'app_router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Screen|Dialog|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/auth',
      page: AuthRouterRoute.page,
      guards: [],
      children: [
        AutoRoute(path: '', page: AuthRoute.page),
        AutoRoute(
          path: 'license-information',
          page: LicenseInformationRoute.page,
        ),
      ],
    ),
    AutoRoute(
      path: '/configurer',
      page: ConfigurerRoute.page,
      guards: [DisableConfigGuard()],
    ),
    AutoRoute(path: '/config-error', page: ConfigErrorStateRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page, guards: [ConfigGuard()]),
    AutoRoute(
      path: '/dashboard',
      page: DashboardRoute.page,
      initial: true,
      guards: [ConfigGuard(), LoginGuard()],
      children: [
        RedirectRoute(path: '', redirectTo: 'taxi/overview'),
        AutoRoute(page: NotificationsRoute.page, path: 'notifications'),
        ...ManagementCommonRouter().routes,
        ...CustomerRouter().routes,
        ...AccountingRouter().routes,
        ...MarketingRouter().routes,
        ...TaxiRouter().routes,
        ...ShopRouter().routes,
        ...ParkingRouter().routes,
        ...PayoutRouter().routes,
        ...SettingsRouter().routes,
        ...PlatformOverviewRouter().routes,
      ],
    ),
  ];
}
