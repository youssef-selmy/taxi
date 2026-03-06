import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSwitch)
Widget defaultSwitch(BuildContext context) {
  return AppSwitch(
    isSelected: context.knobs.boolean(
      label: 'Is selected',
      initialValue: false,
      description: 'Determines whether the switch is on or off',
    ),
    onChanged: (value) {},
    size: context.knobs.object.dropdown(
      label: "Size",
      options: AppSwitchSize.values.map((size) => size).toList(),
      initialOption: AppSwitchSize.medium,
      labelBuilder: (value) => value.name,
      description: 'Select the size of the switch',
    ),
    isDisabled: false,
  );
}
