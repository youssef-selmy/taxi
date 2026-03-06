import 'package:better_design_system/atoms/input_fields/pin_field/pin_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppPinField)
Widget appPinput(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AppPinField(
        length: context.knobs.int.input(label: 'length', initialValue: 6),
        onChanged: (p0) {},
        onCompleted: (p0) {},
      ),
    ],
  );
}
