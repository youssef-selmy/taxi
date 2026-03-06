import 'package:better_design_system/molecules/horizontal_date_picker/horizontal_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppHorizontalDatePicker)
Widget defaultHorizontalDatePicker(BuildContext context) {
  return AppHorizontalDatePicker(
    selectedDate: DateTime.now(),
    onDateSelected: (date) {},
  );
}
