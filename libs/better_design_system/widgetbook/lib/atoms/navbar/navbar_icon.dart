import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNavbarIcon)
Widget appNavbarIcon(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      AppNavbarIcon(
        icon: BetterIcons.settings01Outline,
        badgeNumber: 3,
        isSelected: context.knobs.boolean(
          label: 'Selected',
          initialValue: false,
        ),
      ),
      AppNavbarIcon(
        icon: BetterIcons.settings01Outline,
        badgeNumber: 3,
        isSelected: context.knobs.boolean(
          label: 'Selected',
          initialValue: false,
        ),
        style: NavbarIconStyle.primary,
        onPressed: () {},
      ),
    ],
  );
}
