import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/molecules/popup_menu_button/popup_menu_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppPopupMenuButton)
Widget defaultPopupMenuButton(BuildContext context) {
  return AppPopupMenuButton(
    items: [
      AppPopupMenuItem(
        onPressed: () {},
        title: 'Settings',
        icon: BetterIcons.settings01Filled,
      ),
      AppPopupMenuItem(
        onPressed: () {},
        title: 'Profile',
        icon: BetterIcons.userFilled,
      ),
      AppPopupMenuItem(
        onPressed: () {},
        title: 'Logout',
        hasDivider: true,
        icon: BetterIcons.logout01Filled,
        color: SemanticColor.error,
      ),
    ],

    childBuilder:
        (onPressed) => AppIconButton(
          icon: BetterIcons.moreHorizontalCircle01Filled,
          onPressed: () {
            onPressed();
          },
        ),
  );
}
