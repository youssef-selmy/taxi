import 'package:better_design_system/atoms/toggle_switch_button/toggle_switch_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppToggleSwitchButton)
Widget defaultToggleSwitchButton(BuildContext context) {
  return Column(
    spacing: 30,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppToggleSwitchButton(
        value: context.knobs.boolean(label: 'value', initialValue: false),
        label: 'Label',
        icon: BetterIcons.moon02Outline,
        isDisabled: context.knobs.boolean(
          label: 'isDisabled',
          initialValue: false,
        ),
        isRounded: context.knobs.boolean(label: 'Rounded', initialValue: false),
        onChanged: (value) {},
      ),
      AppToggleSwitchButton(
        value: context.knobs.boolean(label: 'value', initialValue: false),
        label: 'Label',

        isDisabled: context.knobs.boolean(
          label: 'isDisabled',
          initialValue: false,
        ),
        isRounded: context.knobs.boolean(label: 'Rounded', initialValue: false),
        onChanged: (value) {},
      ),
      AppToggleSwitchButton(
        value: context.knobs.boolean(label: 'value', initialValue: false),
        icon: BetterIcons.moon02Outline,
        isDisabled: context.knobs.boolean(
          label: 'isDisabled',
          initialValue: false,
        ),
        isRounded: context.knobs.boolean(label: 'Rounded', initialValue: false),
        onChanged: (value) {},
      ),
    ],
  );
}
