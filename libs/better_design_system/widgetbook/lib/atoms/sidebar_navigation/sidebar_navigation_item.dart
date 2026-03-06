import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSidebarNavigationItem)
Widget appSidebarNavigationItem(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSidebarNavigationItem(
              style: context.knobs.object.dropdown(
                label: 'Style',
                options: SidebarNavigationItemStyle.values,
                initialOption: SidebarNavigationItemStyle.fill,
              ),
              item: NavigationItem(
                title: 'Sidebar',
                icon: (
                  BetterIcons.settings01Filled,
                  BetterIcons.settings01Outline,
                ),
                value: 2,
                badgeNumber: 2,
                badgeTitle: 'Badge',
              ),
              isCollapsed: context.knobs.boolean(
                label: 'Collapsed',
                initialValue: false,
              ),
              selectedItem: 4,
              isItemExpanded: false,
              onItemSelected: (value) {},
              onItemExpansionChanged: (page, value) {},
            ),
            AppSidebarNavigationItem(
              style: context.knobs.object.dropdown(
                label: 'Style',
                options: SidebarNavigationItemStyle.values,
                initialOption: SidebarNavigationItemStyle.fill,
              ),
              isCollapsed: context.knobs.boolean(
                label: 'Collapsed',
                initialValue: false,
              ),
              item: NavigationItem(
                title: 'title',
                icon: (
                  BetterIcons.settings01Filled,
                  BetterIcons.settings01Outline,
                ),
                value: 2,
                badgeNumber: 2,
                badgeTitle: 'Badge',
              ),
              selectedItem: 4,
              isItemExpanded: false,
              onItemSelected: (value) {},
              onItemExpansionChanged: (page, value) {},
            ),
          ],
        ),
      ),
    ],
  );
}
