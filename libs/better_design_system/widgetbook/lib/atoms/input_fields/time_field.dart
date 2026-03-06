import 'package:better_design_system/atoms/input_fields/time_field/time_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppTimeField)
Widget defaultTimeField(BuildContext context) {
  return AppTimeField(onChanged: (_) {});
}
