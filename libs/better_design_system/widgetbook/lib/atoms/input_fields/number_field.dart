import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/material.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNumberField)
Widget defaultAppNumberField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppNumberField(
      maxValue: 100,
      decimalPlaces: 2,
      title: 'Title',
      hint: 'Hint',
      subtitle: 'Helper Text',
    ),
  );
}

@UseCase(name: 'Only Integer', type: AppNumberField)
Widget onlyIntegerAppNumberField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppNumberField(
      onlyInteger: true,
      maxValue: 100,
      title: 'Title',
      hint: 'Hint',
      subtitle: 'Helper Text',
    ),
  );
}
