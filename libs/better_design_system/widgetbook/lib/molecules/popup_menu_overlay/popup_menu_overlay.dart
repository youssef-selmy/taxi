import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_design_system/molecules/popup_menu_overlay/popup_menu_overlay.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppPopupMenuOverlay)
Widget defaultPopupMenuOverlay(BuildContext context) {
  return AppPopupMenuOverlay(
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
    onItemSelected: () {},
  );
}
