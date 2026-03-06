import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_sub_item.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSidebarNavigationSubItem)
Widget appSidebarNavigationSubItem(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSidebarNavigationSubItem(
              style: context.knobs.object.dropdown(
                label: 'Style',
                options: SidebarNavigationItemStyle.values,
                labelBuilder: (option) => option.name,
                initialOption: SidebarNavigationItemStyle.fill,
              ),
              item: NavigationSubItem(
                title: 'Sidebar',
                value: 2,
                badgeNumber: 2,
                badgeTitle: 'Badge',
                hasDot: true,
              ),
              selectedSubItem: 4,
              onPressed: () {},
            ),
            AppSidebarNavigationSubItem(
              style: context.knobs.object.dropdown(
                label: 'Style',
                options: SidebarNavigationItemStyle.values,
                labelBuilder: (option) => option.name,
                initialOption: SidebarNavigationItemStyle.fill,
              ),
              item: NavigationSubItem(
                title: 'title',
                value: 2,
                badgeNumber: 2,
                badgeTitle: 'Badge',
                hasDot: true,
              ),
              selectedSubItem: 4,
              onPressed: () {},
            ),
          ],
        ),
      ),
    ],
  );
}
