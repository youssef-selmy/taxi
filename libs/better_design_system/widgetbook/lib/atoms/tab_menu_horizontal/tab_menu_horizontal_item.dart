import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_item.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'appTabMenuHorizontalItemWithIcon',
  type: AppTabMenuHorizontalItem,
)
Widget appTabMenuHorizontalItemWithIcon(BuildContext context) {
  final bool isSelected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );

  final bool showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppTabMenuHorizontalItem(
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: TabMenuHorizontalStyle.values,
      labelBuilder: (value) => value.name,
    ),
    color: context.knobs.semanticColor,
    selectedValue: isSelected ? 1 : 0,
    item: TabMenuHorizontalOption(
      icon: BetterIcons.userOutline,
      title: 'Tab menu',
      value: 1,
      showArrow: context.knobs.boolean(label: 'Show Arrow', initialValue: true),
      badgeNumber: showBadge ? 4 : null,
    ),
    onPressed: (value) {},
  );
}

@UseCase(
  name: 'appTabMenuHorizontalItemWithPrifixWidget',
  type: AppTabMenuHorizontalItem,
)
Widget appTabMenuHorizontalItemWithPrifixWidget(BuildContext context) {
  final bool isSelected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );

  final bool showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppTabMenuHorizontalItem(
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: TabMenuHorizontalStyle.values,
      labelBuilder: (value) => value.name,
    ),
    color: context.knobs.semanticColor,
    selectedValue: isSelected ? 1 : 0,
    item: TabMenuHorizontalOption(
      prefixWidget: FlutterLogo(size: 20),
      title: 'Tab menu',
      value: 1,
      showArrow: context.knobs.boolean(label: 'Show Arrow', initialValue: true),
      badgeNumber: showBadge ? 4 : null,
    ),
    onPressed: (value) {},
  );
}
