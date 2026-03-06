import 'package:better_design_system/atoms/time_picker_spinner/time_picker_spinner.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'default', type: AppTimePickerSpinner)
Widget appTimePickerSpinner(BuildContext context) {
  return AppTimePickerSpinner(onTimeChange: (time) {});
}
