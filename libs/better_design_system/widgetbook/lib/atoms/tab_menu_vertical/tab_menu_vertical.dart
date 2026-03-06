import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'appTabMenuHorizontalItem', type: AppTabMenuVertical)
Widget appTabMenuVertical(BuildContext context) {
  final bool showTitle = context.knobs.boolean(
    label: 'Show Title',
    initialValue: true,
  );
  final bool showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppTabMenuVertical(
    title: showTitle ? 'Select menu' : null,
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: TabMenuVerticalStyle.values,
      labelBuilder: (value) => value.name,
    ),
    type: context.knobs.object.dropdown(
      label: 'Type',
      options: TabMenuVerticalType.values,
      labelBuilder: (value) => value.name,
    ),
    items: [
      TabMenuVerticalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 1,
        badgeNumber: showBadge ? 3 : null,
      ),
      TabMenuVerticalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 2,
        badgeNumber: showBadge ? 3 : null,
      ),
      TabMenuVerticalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 3,
        badgeNumber: showBadge ? 3 : null,
      ),
      TabMenuVerticalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 4,
        badgeNumber: showBadge ? 3 : null,
      ),
      TabMenuVerticalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 5,
        badgeNumber: showBadge ? 3 : null,
      ),
      TabMenuVerticalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 6,
        badgeNumber: showBadge ? 3 : null,
      ),
    ],
    selectedValue: context.knobs.int.slider(
      label: 'Selected Value',
      initialValue: 0,
      min: 0,
      max: 6,
    ),
    onChanged: (value) {},
  );
}
