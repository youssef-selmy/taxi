import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ManagementCommonRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RegionsShellRoute.page,
      path: "regions",
      children: [
        AutoRoute(page: RegionsListRoute.page, path: "list", initial: true),
        AutoRoute(page: RegionDetailsRoute.page, path: "view/:regionId"),
        AutoRoute(
          page: RegionCategoryDetailsRoute.page,
          path: "category/:regionCategoryId",
        ),
      ],
    ),
    AutoRoute(
      page: PaymentGatewayParentRoute.page,
      path: 'payment-gateway',
      children: [
        AutoRoute(
          page: PaymentGatewaysListRoute.page,
          path: "list",
          initial: true,
        ),
        AutoRoute(
          page: PaymentGatewayDetailsRoute.page,
          path: "view/:paymentGatewayId",
        ),
      ],
    ),
    AutoRoute(
      page: SmsProviderParentRoute.page,
      path: 'sms-provider',
      children: [
        AutoRoute(page: SmsProviderListRoute.page, path: "list", initial: true),
        AutoRoute(
          page: SmsProviderDetailsRoute.page,
          path: "view/:smsProviderId",
        ),
      ],
    ),
    AutoRoute(
      page: EmailProviderParentRoute.page,
      path: 'email-provider',
      children: [
        AutoRoute(
          page: EmailProviderListRoute.page,
          path: "list",
          initial: true,
        ),
        AutoRoute(
          page: EmailProviderDetailsRoute.page,
          path: "view/:emailProviderId",
        ),
      ],
    ),
    AutoRoute(
      page: EmailTemplateParentRoute.page,
      path: 'email-template',
      children: [
        AutoRoute(
          page: EmailTemplateListRoute.page,
          path: "list",
          initial: true,
        ),
        AutoRoute(
          page: EmailTemplateDetailsRoute.page,
          path: "view/:emailTemplateId",
        ),
      ],
    ),
    AutoRoute(
      page: StaffParrentRoute.page,
      path: 'staffs',
      children: [
        RedirectRoute(path: "", redirectTo: "list"),
        AutoRoute(page: StaffListRoute.page, path: "list"),
        AutoRoute(page: StaffDetailRoute.page, path: "view/:staffDetail"),
        AutoRoute(page: NewStaffRoute.page, path: "create"),
        AutoRoute(page: StaffRoleListRoute.page, path: "roles"),
        AutoRoute(
          page: StaffRoleDetailRoute.page,
          path: "roles/view/:staffRoleId",
        ),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(
    BuildContext context,
    List<NavigationSubItem<PageRouteInfo>> additionalSubItems,
  ) => NavigationItem(
    title: context.tr.management,
    value: ManagementCommonRoute(),
    icon: (
      BetterIcons.filterHorizontalOutline,
      BetterIcons.filterHorizontalFilled,
    ),
    subItems: [
      ...additionalSubItems,
      NavigationSubItem(title: context.tr.regions, value: RegionsShellRoute()),
      NavigationSubItem(
        title: context.tr.paymentGateways,
        value: PaymentGatewayParentRoute(),
      ),
      NavigationSubItem(
        title: context.tr.smsProviders,
        value: SmsProviderParentRoute(),
      ),
      NavigationSubItem(
        title: context.tr.emailProviders,
        value: EmailProviderParentRoute(),
      ),
      NavigationSubItem(
        title: context.tr.emailTemplates,
        value: EmailTemplateParentRoute(),
      ),
      NavigationSubItem(title: context.tr.staff, value: StaffParrentRoute()),
    ],
  );
}
