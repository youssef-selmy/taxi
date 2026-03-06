import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/features/hr_platform/entities/hr_platform_dashboard_page.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_logo.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_section.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_user_profile.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_faker/image_faker.dart';

export 'package:better_design_showcase/features/hr_platform/entities/hr_platform_dashboard_page.dart';

class HrPlatformSidebar extends StatefulWidget {
  final ThemeMode? initialTheme;
  const HrPlatformSidebar({
    super.key,
    this.selectedItem = HrPlatformSidebarPage.dashboard,
    this.initialTheme,
  });

  final HrPlatformSidebarPage selectedItem;

  @override
  State<HrPlatformSidebar> createState() => _HrPlatformSidebarState();
}

class _HrPlatformSidebarState extends State<HrPlatformSidebar> {
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
      child: AppSidebarNavigation<HrPlatformSidebarPage>(
        collapsable: true,
        showDivider: true,
        header: AppSidebarNavigationLogo(
          logoUrl: ImageFaker().appLogo.taxi,
          title: 'HR Platform',
        ),
        style: SidebarNavigationItemStyle.primary,
        data: [
          NavigationItem(
            title: 'Dashboard',
            value: HrPlatformSidebarPage.dashboard,
            icon: (BetterIcons.home01Outline, BetterIcons.home01Filled),
            section: SidebarNavigationSection(
              title: 'Menu',
              value: HrPlatformSidebarPage.menu,
            ),
          ),
          NavigationItem(
            title: 'Projects',
            value: HrPlatformSidebarPage.projects,
            icon: (BetterIcons.noteOutline, BetterIcons.noteFilled),
            section: SidebarNavigationSection(
              title: 'Menu',
              value: HrPlatformSidebarPage.menu,
            ),
            subItems: [
              NavigationSubItem(
                title: 'Overview',
                value: HrPlatformSidebarPage.projects,
              ),
            ],
          ),
          NavigationItem(
            title: 'Tasks',
            value: HrPlatformSidebarPage.tasks,
            icon: (
              BetterIcons.checkmarkSquare02Outline,
              BetterIcons.checkmarkSquare02Filled,
            ),
            section: SidebarNavigationSection(
              title: 'Menu',
              value: HrPlatformSidebarPage.menu,
            ),
            badgeNumber: 2,
          ),
          NavigationItem(
            title: 'Calendar',
            value: HrPlatformSidebarPage.calendar,
            icon: (BetterIcons.calendar01Outline, BetterIcons.calendar01Filled),
            section: SidebarNavigationSection(
              title: 'Menu',
              value: HrPlatformSidebarPage.menu,
            ),
          ),
          NavigationItem(
            title: 'Inbox',
            value: HrPlatformSidebarPage.inbox,
            icon: (BetterIcons.message02Outline, BetterIcons.message02Filled),
            section: SidebarNavigationSection(
              title: 'Menu',
              value: HrPlatformSidebarPage.menu,
            ),
          ),
          NavigationItem(
            title: 'Performance',
            value: HrPlatformSidebarPage.performance,
            icon: (
              BetterIcons.analytics01Outline,
              BetterIcons.analytics01Filled,
            ),
            section: SidebarNavigationSection(
              title: 'Menu',
              value: HrPlatformSidebarPage.menu,
            ),
          ),
          NavigationItem(
            title: 'Report & Analytics',
            value: HrPlatformSidebarPage.reportAndAnalytics,
            icon: (BetterIcons.chart03Outline, BetterIcons.chart03Filled),
            section: SidebarNavigationSection(
              title: 'Menu',
              value: HrPlatformSidebarPage.menu,
            ),
          ),
          NavigationItem(
            title: 'Employees',
            value: HrPlatformSidebarPage.employees,
            icon: (
              BetterIcons.userGroup02Outline,
              BetterIcons.userGroup03Filled,
            ),
            section: SidebarNavigationSection(
              title: 'Management',
              value: HrPlatformSidebarPage.employees,
            ),
          ),
          NavigationItem(
            title: 'Recruitment',
            value: HrPlatformSidebarPage.recruitment,
            icon: (BetterIcons.userAdd01Outline, BetterIcons.userAdd01Filled),
            section: SidebarNavigationSection(
              title: 'Management',
              value: HrPlatformSidebarPage.employees,
            ),
          ),
          NavigationItem(
            title: 'Payroll',
            value: HrPlatformSidebarPage.payroll,
            icon: (BetterIcons.wallet01Outline, BetterIcons.wallet01Filled),
            section: SidebarNavigationSection(
              title: 'Management',
              value: HrPlatformSidebarPage.employees,
            ),
          ),
          NavigationItem(
            title: 'Settings',
            value: HrPlatformSidebarPage.settings,
            icon: (BetterIcons.settings01Outline, BetterIcons.settings01Filled),
            section: SidebarNavigationSection(
              title: 'Support',
              value: HrPlatformSidebarPage.support,
            ),
          ),
          NavigationItem(
            title: 'Help Center',
            value: HrPlatformSidebarPage.helpCenter,
            icon: (BetterIcons.helpCircleOutline, BetterIcons.helpCircleFilled),
            section: SidebarNavigationSection(
              title: 'Support',
              value: HrPlatformSidebarPage.support,
            ),
          ),
        ],
        selectedItem: widget.selectedItem,
        onItemSelected: (value) {},
        footer: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24),
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
