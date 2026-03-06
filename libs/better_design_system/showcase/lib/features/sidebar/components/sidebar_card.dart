import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_logo.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_section.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_user_profile.dart';
import 'package:better_design_system/molecules/dark_light_switch/dark_light_switch.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

enum Pages {
  dashboard,
  dashboardOverview,
  dashboardAnalytics,
  orders,
  products,
  inventory,
  customers,
  pendingCustomers,
  allCustomers,
  analytics,
  marketing,
  support,
  settings,
}

class SidebarCard extends StatefulWidget {
  final ThemeMode selectedThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const SidebarCard({
    super.key,
    required this.selectedThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  State<SidebarCard> createState() => _SidebarCardState();
}

class _SidebarCardState extends State<SidebarCard> {
  Pages selectedItem = Pages.dashboard;

  String _getPageTitle(Pages page) => switch (page) {
    Pages.dashboard => 'Dashboard',
    Pages.dashboardOverview => 'Dashboard Overview',
    Pages.dashboardAnalytics => 'Dashboard Analytics',
    Pages.orders => 'Orders',
    Pages.products => 'Products',
    Pages.inventory => 'Inventory',
    Pages.customers => 'Customers',
    Pages.pendingCustomers => 'Pending Customers',
    Pages.allCustomers => 'All Customers',
    Pages.analytics => 'Analytics',
    Pages.marketing => 'Marketing',
    Pages.support => 'Support',
    Pages.settings => 'Settings',
  };

  String _getPageDescription(Pages page) => switch (page) {
    Pages.dashboard => 'Overview of your business metrics and performance',
    Pages.dashboardOverview => 'Detailed overview of dashboard components',
    Pages.dashboardAnalytics => 'Analytics data for dashboard metrics',
    Pages.orders => 'Manage and track all customer orders',
    Pages.products => 'Browse and manage your product catalog',
    Pages.inventory => 'Track stock levels and inventory management',
    Pages.customers => 'View and manage customer information',
    Pages.pendingCustomers => 'Customers pending verification',
    Pages.allCustomers => 'Complete list of all customers',
    Pages.analytics => 'Business insights and analytics reports',
    Pages.marketing => 'Marketing campaigns and performance',
    Pages.support => 'Customer support and help desk',
    Pages.settings => 'Application settings and preferences',
  };

  @override
  Widget build(BuildContext context) {
    final menuSection = SidebarNavigationSection(title: 'Menu', value: 'menu');
    final helpSection = SidebarNavigationSection(title: 'Help', value: 'help');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSidebarNavigation<Pages>(
          collapsable: true,
          collapsedWidth: 150,
          showDivider: true,
          style: SidebarNavigationItemStyle.primary,
          selectedItem: selectedItem,
          footer: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19, right: 19, bottom: 16),
                child: AppDarkLightSwitch(
                  selectedThemeMode: widget.selectedThemeMode,
                  onThemeModeChanged: widget.onThemeModeChanged,
                ),
              ),
              const AppDivider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: AppSidebarNavigationUserProfile(
                  avatarUrl: ImageFaker().person.one,
                  onPressed: () {},
                  style: SidebarNavigationUserProfileStyle.soft,
                ),
              ),
            ],
          ),
          header: AppSidebarNavigationLogo(
            logoUrl: ImageFaker().appLogo.taxi,
            onPressed: () {},
          ),
          onItemSelected: (value) {
            setState(() {
              selectedItem = value;
            });
          },
          data: [
            NavigationItem(
              title: 'Dashboard',
              value: Pages.dashboard,
              icon: (BetterIcons.home01Outline, BetterIcons.home01Filled),
              section: menuSection,
              badgeNumber: 3,
              subItems: [
                NavigationSubItem(
                  title: 'Overview',
                  value: Pages.dashboardOverview,
                ),
                NavigationSubItem(
                  title: 'Analytics',
                  value: Pages.dashboardAnalytics,
                  hasDot: true,
                ),
              ],
            ),
            NavigationItem(
              title: 'Orders',
              value: Pages.orders,
              icon: (
                BetterIcons.shoppingBag02Outline,
                BetterIcons.shoppingBag02Filled,
              ),
              section: menuSection,
              badgeNumber: 12,
            ),
            NavigationItem(
              title: 'Products',
              value: Pages.products,
              icon: (
                BetterIcons.discountTag02Outline,
                BetterIcons.discountTag02Filled,
              ),
              section: menuSection,
            ),
            NavigationItem(
              title: 'Inventory',
              value: Pages.inventory,
              icon: (
                BetterIcons.pieChart01Outline,
                BetterIcons.pieChart01Filled,
              ),
              section: menuSection,
            ),
            NavigationItem(
              title: 'Customers',
              value: Pages.customers,
              icon: (
                BetterIcons.userMultipleOutline,
                BetterIcons.userMultipleFilled,
              ),
              section: menuSection,
              hasDot: true,
              subItems: [
                NavigationSubItem(
                  title: 'Pending Verification',
                  value: Pages.pendingCustomers,
                ),
                NavigationSubItem(
                  title: 'All Customers',
                  value: Pages.allCustomers,
                  hasDot: true,
                ),
              ],
            ),
            NavigationItem(
              title: 'Analytics',
              value: Pages.analytics,
              icon: (
                BetterIcons.analytics01Outline,
                BetterIcons.analytics01Filled,
              ),
              section: menuSection,
            ),
            NavigationItem(
              title: 'Marketing',
              value: Pages.marketing,
              icon: (BetterIcons.gps01Outline, BetterIcons.gps01Filled),
              section: menuSection,
            ),
            NavigationItem(
              title: 'Support',
              value: Pages.support,
              icon: (
                BetterIcons.headphonesOutline,
                BetterIcons.headphonesFilled,
              ),
              section: helpSection,
            ),
            NavigationItem(
              title: 'Settings',
              value: Pages.settings,
              icon: (
                BetterIcons.settings01Outline,
                BetterIcons.settings01Filled,
              ),
              section: helpSection,
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getPageTitle(selectedItem),
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  _getPageDescription(selectedItem),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.colors.outline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Icon(
                            BetterIcons.informationCircleOutline,
                            size: 20,
                            color: context.colors.primary,
                          ),
                          Text(
                            'Page Content',
                            style: context.textTheme.labelLarge?.copyWith(
                              color: context.colors.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This is the main content area for ${_getPageTitle(selectedItem)}. You can add your page-specific components and content here.',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
