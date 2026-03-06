import 'package:better_design_system/atoms/navbar/navbar_action_item.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNavbarActionItem)
Widget appNavbarActionItem(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      AppNavbarActionItem(
        title: 'Navbar',
        isSelected: context.knobs.boolean(
          label: 'isSelected',
          initialValue: false,
        ),
        icon: BetterIcons.settings01Outline,
        badgeNumber: 3,
        badgeTitle: 'badge',
        style: NavbarActionItemStyle.primary,
      ),
      AppNavbarActionItem(
        title: 'Navbar',
        isSelected: context.knobs.boolean(
          label: 'isSelected',
          initialValue: false,
        ),
        icon: BetterIcons.settings01Outline,
        badgeNumber: 2,
      ),
      AppNavbarActionItem(
        title: 'Navbar',
        isSelected: context.knobs.boolean(
          label: 'isSelected',
          initialValue: false,
        ),
        icon: BetterIcons.settings01Outline,
        badgeTitle: 'badge',
      ),
      AppNavbarActionItem(
        title: 'Navbar',
        icon: BetterIcons.settings01Outline,
        isSelected: context.knobs.boolean(
          label: 'isSelected',
          initialValue: false,
        ),
      ),
    ],
  );
}
