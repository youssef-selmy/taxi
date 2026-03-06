import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_item.dart';
import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_option.dart';
import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_style.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'appTabMenuHorizontalItem', type: AppTabMenuVerticalItem)
Widget appTabMenuVerticalItem(BuildContext context) {
  final bool isSelected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );
  final bool showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return SizedBox(
    width: 170,
    child: AppTabMenuVerticalItem(
      style: context.knobs.object.dropdown(
        label: 'Style',
        options: TabMenuVerticalStyle.values,
        labelBuilder: (value) => value.name,
      ),
      selectedValue: isSelected ? 1 : 0,
      item: TabMenuVerticalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 1,
        badgeNumber: showBadge ? 3 : null,
      ),
      onPressed: (int value) {},
    ),
  );
}
