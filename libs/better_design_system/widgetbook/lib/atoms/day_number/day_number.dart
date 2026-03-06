import 'package:better_design_system/atoms/day_number/day_number.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDayNumber)
Widget defaultAppDayNumber(BuildContext context) {
  return AppDayNumber(
    // inRange: context.knobs.boolean(label: 'In Range', initialValue: false),
    isActive: context.knobs.boolean(label: 'Is Active', initialValue: false),
    isDisabled: context.knobs.boolean(
      label: 'Is Disabled',
      initialValue: false,
    ),
    isSelected: context.knobs.boolean(
      label: 'Is Selected',
      initialValue: false,
    ),
    hasDot: context.knobs.boolean(label: 'Has Dot', initialValue: false),
    type: context.knobs.object.dropdown(
      label: 'Type',
      options: DayNumberType.values,
      labelBuilder: (value) => value.name,
    ),
    title: '1',
    onPressed: () {},
  );
}
