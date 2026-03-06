import 'package:better_design_system/molecules/date_picker_dialog/date_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDatePickerDialog)
Widget appAppDatePickerDialog(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 200),
    child: AppDatePickerDialog(
      isRangeMode: context.knobs.boolean(
        label: 'Range Selected',
        initialValue: false,
      ),
      title: 'Select Time',
      onChangedRange: (value) {},

      onChanged: (value) {},
      pickTime: context.knobs.boolean(label: 'Pick Time', initialValue: false),
      events: [
        DateTime(2025, 5, 26),
        DateTime(2025, 5, 31),
        DateTime(2025, 5, 28),
      ],
    ),
  );
}
