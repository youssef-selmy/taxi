import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/settings/presentation/blocs/settings.bloc.dart';

List<NavigationItem<PageRouteInfo>> navigationItemsFor(
  BuildContext context,
) => [
  NavigationItem(
    title: context.tr.generalSettings,
    value: SettingsGeneralRoute(),
    icon: (BetterIcons.userOutline, BetterIcons.userFilled),
  ),
  NavigationItem(
    title: context.tr.appearance,
    value: SettingsAppearanceRoute(),
    icon: (BetterIcons.paintBoardOutline, BetterIcons.paintBoardFilled),
  ),
  NavigationItem(
    title: context.tr.brandingDetails,
    value: SettingsBrandingRoute(),
    icon: (BetterIcons.city02Outline, BetterIcons.city02Filled),
  ),
  NavigationItem(
    title: "Dispatch Settings",
    value: SettingsDispatchRoute(),
    icon: (BetterIcons.car05Outline, BetterIcons.car05Filled),
  ),
  NavigationItem(
    title: context.tr.notifications,
    value: SettingsNotificationRoute(),
    icon: (BetterIcons.notification02Outline, BetterIcons.notification02Filled),
  ),
  NavigationItem(
    title: context.tr.mapSettings,
    value: SettingsMapRoute(),
    icon: (BetterIcons.mapsOutline, BetterIcons.mapsFilled),
  ),
  NavigationItem(
    title: context.tr.systemSettings,
    value: SettingsSystemRoute(),
    icon: (BetterIcons.wrench01Outline, BetterIcons.wrench01Filled),
  ),
  // NavigationItem(
  //   title: context.tr.activeSessions,
  //   value: SettingsSessionsRoute(),
  //   icon: (BetterIcons.smartPhone01Outline, BetterIcons.smartPhone01Filled),
  // ),
  NavigationItem(
    title: context.tr.password,
    value: SettingsPasswordRoute(),
    icon: (BetterIcons.key01Outline, BetterIcons.key01Filled),
  ),
  NavigationItem(
    title: context.tr.softwareLicense,
    value: SettingsSubscriptionRoute(),
    icon: (BetterIcons.starAward01Outline, BetterIcons.starAward01Filled),
  ),
];

class SettingsShellScreenDesktop extends StatelessWidget {
  final Widget child;

  const SettingsShellScreenDesktop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageHeader(
            title: context.tr.settings,
            subtitle: context.tr.manageAccountSettingsPreferences,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: AppSidebarNavigation<PageRouteInfo?>(
                              expandedWidth: 290,
                              selectedItem:
                                  state.selectedRoute ?? SettingsGeneralRoute(),
                              onItemSelected: (item) {
                                context.read<SettingsBloc>().goToRoute(item);
                                context.router.navigate(item!);
                              },
                              data: navigationItemsFor(context),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
