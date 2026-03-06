import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRadio)
Widget defaultRadio(BuildContext context) {
  return AppRadio(
    value: context.knobs.boolean(label: 'Value', initialValue: false),
    groupValue: true,
    onTap: (value) {
      // Handle radio button tap
    },
    size: context.knobs.object.dropdown(
      label: 'Size',
      options: RadioSize.values,
      initialOption: RadioSize.medium,
      labelBuilder: (value) => value.name,
    ),
    isDisabled: context.knobs.boolean(label: 'isDisabled', initialValue: false),
  );
}
