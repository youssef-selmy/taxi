import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'appTabMenuHorizontalWithIcon', type: AppTabMenuHorizontal)
Widget appTabMenuHorizontalWithIcon(BuildContext context) {
  final bool showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppTabMenuHorizontal(
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: TabMenuHorizontalStyle.values,
      labelBuilder: (value) => value.name,
    ),
    selectedValue: context.knobs.int.slider(
      label: 'Selected Value',
      initialValue: 1,
      min: 1,
      max: 4,
    ),
    tabs: [
      TabMenuHorizontalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 1,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
      TabMenuHorizontalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 2,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
      TabMenuHorizontalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 3,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
      TabMenuHorizontalOption(
        icon: BetterIcons.userOutline,
        title: 'Tab menu',
        value: 4,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
    ],
    onChanged: (int value) {},
  );
}

@UseCase(name: 'appTabMenuHorizontalWithPrefix', type: AppTabMenuHorizontal)
Widget appTabMenuHorizontalWithPrefix(BuildContext context) {
  final bool showBadge = context.knobs.boolean(
    label: 'Show Badge',
    initialValue: false,
  );
  return AppTabMenuHorizontal(
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: TabMenuHorizontalStyle.values,
      labelBuilder: (value) => value.name,
    ),
    selectedValue: context.knobs.int.slider(
      label: 'Selected Value',
      initialValue: 1,
      min: 1,
      max: 4,
    ),
    tabs: [
      TabMenuHorizontalOption(
        prefixWidget: FlutterLogo(size: 20),
        title: 'Tab menu',
        value: 1,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
      TabMenuHorizontalOption(
        prefixWidget: FlutterLogo(size: 20),
        title: 'Tab menu',
        value: 2,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
      TabMenuHorizontalOption(
        prefixWidget: FlutterLogo(size: 20),
        title: 'Tab menu',
        value: 3,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
      TabMenuHorizontalOption(
        prefixWidget: FlutterLogo(size: 20),
        title: 'Tab menu',
        value: 4,
        showArrow: context.knobs.boolean(
          label: 'Show Arrow',
          initialValue: true,
        ),
        badgeNumber: showBadge ? 7 : null,
      ),
    ],
    onChanged: (int value) {},
  );
}
