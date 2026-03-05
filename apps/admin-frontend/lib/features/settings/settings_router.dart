import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

class SettingsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SettingsShellRoute.page,
      path: 'settings',
      children: [
        AutoRoute(
          page: SettingsGeneralRoute.page,
          path: 'general',
          initial: true,
        ),
        AutoRoute(page: SettingsAppearanceRoute.page, path: 'appearance'),
        AutoRoute(page: SettingsBrandingRoute.page, path: 'branding'),
        AutoRoute(page: SettingsSystemRoute.page, path: 'system'),
        AutoRoute(page: SettingsDispatchRoute.page, path: 'dispatch'),
        AutoRoute(page: SettingsNotificationRoute.page, path: 'notification'),
        AutoRoute(page: SettingsMapRoute.page, path: 'map'),
        AutoRoute(page: SettingsSessionsRoute.page, path: 'sessions'),
        AutoRoute(page: SettingsPasswordRoute.page, path: 'password'),
        AutoRoute(page: SettingsSubscriptionRoute.page, path: 'subscription'),
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) {
    return NavigationItem(
      title: context.tr.settings,
      value: SettingsShellRoute(),
      icon: (BetterIcons.settings01Outline, BetterIcons.settings01Filled),
    );
  }
}
