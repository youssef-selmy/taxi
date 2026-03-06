import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_logo.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_user_profile.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_faker/image_faker.dart';

import '../../entities/fintech_dashboard_page.dart';

class FintechSidebar extends StatefulWidget {
  final ThemeMode? initialTheme;
  const FintechSidebar({super.key, this.initialTheme});

  @override
  State<FintechSidebar> createState() => _FintechSidebarState();
}

class _FintechSidebarState extends State<FintechSidebar> {
  late ThemeMode selectedThemeMode;

  @override
  void initState() {
    selectedThemeMode =
        widget.initialTheme ?? context.read<SettingsCubit>().state.themeMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: AppSidebarNavigation<FintechDashboardPage>(
        collapsable: false,
        showDivider: true,
        header: AppSidebarNavigationLogo(
          logoUrl: ImageFaker().appLogo.taxi,
          title: 'Fintech',
        ),
        style: SidebarNavigationItemStyle.primary,
        data: [
          NavigationItem(
            title: 'Dashboard',
            value: FintechDashboardPage.dashboard,
            icon: (BetterIcons.home01Outline, BetterIcons.home01Filled),
          ),
          NavigationItem(
            title: 'Transaction',
            value: FintechDashboardPage.transaction,
            icon: (
              BetterIcons.arrowUpDownOutline,
              BetterIcons.arrowUpDownFilled,
            ),
            badgeNumber: 2,
          ),
          NavigationItem(
            title: 'MyCards',
            value: FintechDashboardPage.myCards,
            icon: (BetterIcons.creditCardOutline, BetterIcons.creditCardFilled),
          ),
          NavigationItem(
            title: 'Transfer',
            value: FintechDashboardPage.transfer,
            icon: (BetterIcons.bankOutline, BetterIcons.bankFilled),
          ),
          NavigationItem(
            title: 'Payments',
            value: FintechDashboardPage.payments,
            icon: (BetterIcons.bookmark02Outline, BetterIcons.bookmark02Filled),
          ),
          NavigationItem(
            title: 'Investments',
            value: FintechDashboardPage.investments,
            icon: (
              BetterIcons.analytics01Outline,
              BetterIcons.analytics01Filled,
            ),
          ),
          NavigationItem(
            title: 'Exchange',
            value: FintechDashboardPage.exchange,
            icon: (
              BetterIcons.walletAdd01Outline,
              BetterIcons.walletAdd01Filled,
            ),
          ),
        ],
        selectedItem: FintechDashboardPage.dashboard,
        onItemSelected: (value) {},
        footer: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.outline),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  spacing: 16,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          spacing: 4,
                          children: <Widget>[
                            Icon(
                              BetterIcons.rocket01Outline,
                              size: 24,
                              color: context.colors.primary,
                            ),
                            Text(
                              'Upgrade Plan',
                              style: context.textTheme.labelLarge,
                            ),
                          ],
                        ),

                        AppIconButton(
                          onPressed: () {},
                          icon: BetterIcons.cancelCircleOutline,
                          size: ButtonSize.medium,
                        ),
                      ],
                    ),

                    Text(
                      'Upgrade your plan to premium now to access more features',
                      style: context.textTheme.bodyMedium?.variant(context),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: AppOutlinedButton(
                            onPressed: () {},
                            text: 'Upgrade Now',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppToggleSwitchButtonGroup(
                isExpanded: true,
                isRounded: true,
                options: [
                  ToggleSwitchButtonGroupOption(
                    value: ThemeMode.light,
                    label: 'Light',
                    icon: BetterIcons.sun02Outline,
                    selectedIcon: BetterIcons.sun01Filled,
                  ),
                  ToggleSwitchButtonGroupOption(
                    value: ThemeMode.dark,
                    label: 'Dark',
                    icon: BetterIcons.moon02Outline,
                    selectedIcon: BetterIcons.moon02Filled,
                  ),
                ],
                selectedValue: selectedThemeMode,
                onChanged: (value) {
                  setState(() {
                    selectedThemeMode = value;
                  });
                },
              ),
            ),
            const AppDivider(),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: AppSidebarNavigationUserProfile(
                  avatarUrl: ImageFaker().person.seven,
                  style: SidebarNavigationUserProfileStyle.soft,
                  title: 'Gustavo Kenter',
                  subtitle: 'Gustavo@better.com',
                  onPressed: () {},
                  icon: BetterIcons.moreVerticalCircle01Outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
