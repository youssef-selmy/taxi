import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_logo.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_section.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_user_profile.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_faker/image_faker.dart';
import '../../entities/sales_and_marketing_dashboard_page.dart';

export '../../entities/sales_and_marketing_dashboard_page.dart';

class SalesAndMarketingSidebar extends StatefulWidget {
  final SalesAndMarketingDashboardGroup dashboardGroup;
  final SalesAndMarketingDashboardPage selectedPage;
  final ThemeMode? initialTheme;
  const SalesAndMarketingSidebar({
    super.key,
    this.initialTheme,
    this.dashboardGroup = SalesAndMarketingDashboardGroup.groupA,
    this.selectedPage = SalesAndMarketingDashboardPage.dashboard,
  });

  @override
  State<SalesAndMarketingSidebar> createState() =>
      _SalesAndMarketingSidebarState();
}

class _SalesAndMarketingSidebarState extends State<SalesAndMarketingSidebar> {
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
      child: AppSidebarNavigation<SalesAndMarketingDashboardPage>(
        collapsable: false,
        header: AppSidebarNavigationLogo(
          logoUrl: ImageFaker().appLogo.taxi,
          title: 'Sales & Marketing',
        ),
        showDivider: true,
        style:
            widget.dashboardGroup == SalesAndMarketingDashboardGroup.groupA
                ? SidebarNavigationItemStyle.fill
                : SidebarNavigationItemStyle.primary,
        data: [
          ...pagesByGroup(widget.dashboardGroup).map(
            (config) => NavigationItem(
              title: config.title,
              value: config.page,
              icon: config.icon,
              section: SidebarNavigationSection(
                title: 'Menu',
                value: config.page,
              ),
            ),
          ),

          NavigationItem(
            title: 'Support',
            value: SalesAndMarketingDashboardPage.support,
            icon: (BetterIcons.headphonesOutline, BetterIcons.headphonesFilled),
            section: SidebarNavigationSection(title: 'Help', value: 'Support'),
          ),
          NavigationItem(
            title: 'Setting',
            value: SalesAndMarketingDashboardPage.setting,
            icon: (BetterIcons.settings01Outline, BetterIcons.settings01Filled),
            section: SidebarNavigationSection(title: 'Help', value: 'Setting'),
          ),
        ],
        selectedItem: widget.selectedPage,
        onItemSelected: (value) {},
        footer: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
