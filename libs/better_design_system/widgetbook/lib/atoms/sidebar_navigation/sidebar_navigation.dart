import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_logo.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_user_profile.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

enum Pages {
  home,
  customers,
  pendingVerificationCustomers,
  allCustomers,
  drivers,
  pendingVerificationDrivers,
  allDrivers,
  settings,
}

@UseCase(name: 'Default', type: AppSidebarNavigation)
Widget appSidebarNavigation(BuildContext context) {
  return Scaffold(
    body: Align(
      alignment: Alignment.topLeft,
      child: AppSidebarNavigation<Pages>(
        collapsable: true,
        // expandedWidth: 290,
        collapsedWidth: 160,
        footer: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: AppSidebarNavigationUserProfile(
            avatarUrl: ImageFaker().food.burger,
            onPressed: () {},
          ),
        ),
        selectedItem: context.knobs.object.dropdown(
          label: 'Selected Page',
          options: Pages.values,
          labelBuilder: (value) => value.name,
        ),
        header: AppSidebarNavigationLogo(
          logoUrl: ImageFaker().food.burger,
          onPressed: () {},
        ),
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: SidebarNavigationItemStyle.values,
          initialOption: SidebarNavigationItemStyle.fill,
        ),
        onItemSelected: (value) {},
        data: [
          NavigationItem(
            title: 'Home',
            icon: (BetterIcons.home01Filled, BetterIcons.home01Outline),
            value: Pages.home,
            badgeNumber: 2,
          ),
          NavigationItem(
            title: 'Customers',
            icon: (BetterIcons.userFilled, BetterIcons.userOutline),
            value: Pages.customers,
            badgeNumber: 2,
            hasDot: context.knobs.boolean(label: 'Dot', initialValue: true),
            subItems: [
              NavigationSubItem(
                title: 'Pending Verification',
                value: Pages.pendingVerificationCustomers,
              ),
              NavigationSubItem(
                title: 'All Customers',
                value: Pages.allCustomers,
                hasDot: true,
              ),
            ],
          ),
          NavigationItem(
            title: 'Drivers',
            icon: (BetterIcons.settings01Filled, BetterIcons.settings01Outline),
            value: Pages.drivers,
          ),
        ],
      ),
    ),
  );
}
