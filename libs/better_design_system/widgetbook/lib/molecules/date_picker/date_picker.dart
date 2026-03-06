import 'package:better_design_system/molecules/date_picker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDatePicker)
Widget appDatePicker(BuildContext context) {
  return AppDatePicker(
    showActionButtons: context.knobs.boolean(
      label: 'Show Action Buttons',
      initialValue: false,
    ),
    // activeDate: DateTime(2020, 5, 26),
    // isRangeMode: context.knobs.boolean(
    //   label: 'Range Selected',
    //   initialValue: false,
    // ),
    title: 'Select Time',
    // rangeDate: (DateTime(2025, 5, 12), DateTime(2025, 5, 25)),
    // disabledDates: [
    //   (DateTime(2025, DateTime.may, 19), DateTime(2025, DateTime.may, 22)),
    //   // (DateTime(2025, DateTime.may, 27), DateTime(2025, DateTime.may, 29)),
    // ],
    selectionMode: context.knobs.object.dropdown(
      label: 'Selection Mode',
      options: DatePickerSelectionMode.values,
      labelBuilder: (value) => value.name,
    ),
    onRangeChanged: (start, end) {},
    onChanged: (value) {},
    pickTime: context.knobs.boolean(label: 'Pick Time', initialValue: false),
    events: [
      DateTime(2025, 5, 26),
      DateTime(2025, 5, 31),
      DateTime(2025, 5, 28),
    ],
  );
}
