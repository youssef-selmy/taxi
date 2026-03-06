import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppPhoneNumberField)
Widget defaultPhoneNumberField(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppPhoneNumberField(
      label: context.knobs.string(label: 'Title', initialValue: 'Phone Number'),
      helpText: context.knobs.string(
        label: 'Subtitle',
        initialValue: 'Enter your phone number',
      ),
      initialValue: ("US", null),
    ),
  );
}
