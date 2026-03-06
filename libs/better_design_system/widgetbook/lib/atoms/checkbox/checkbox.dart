import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppCheckbox)
Widget defaultCheckbox(BuildContext context) {
  return AppCheckbox(
    value: context.knobs.boolean(label: 'Value', initialValue: false),
    onChanged: (value) {
      // Handle checkbox change
    },
    size: context.knobs.object.dropdown(
      label: 'Size',
      options: CheckboxSize.values,
      initialOption: CheckboxSize.medium,
      labelBuilder: (value) => value.name,
    ),
    isDisabled: context.knobs.boolean(label: 'isDisabled', initialValue: false),
  );
}
