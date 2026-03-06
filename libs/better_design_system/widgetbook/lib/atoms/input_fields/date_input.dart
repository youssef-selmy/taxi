import 'package:better_design_system/atoms/input_fields/date_input/date_input.dart';
import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDateInput)
Widget appAppDateInput(BuildContext context) {
  final now = DateTime.now();
  return SizedBox(
    width: 362,
    child: AppDateInput(
      label: context.knobs.string(label: 'Label', initialValue: 'Birth Date'),

      isRequired: context.knobs.boolean(
        label: 'Is Required',
        initialValue: false,
      ),
      helpText: context.knobs.stringOrNull(label: 'Help Text'),
      helpTextColor: context.knobs.object.dropdown(
        label: 'Help Text Color',
        options: SemanticColor.values,
        labelBuilder: (value) => value.name,
      ),
      isFilled: context.knobs.boolean(label: 'Filled', initialValue: true),
      isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false),
      initialValue:
          context.knobs.boolean(label: 'With Initial Date?', initialValue: true)
              ? DateTime(now.year, now.month, now.day)
              : null,
      density: context.knobs.object.dropdown(
        label: 'Density',
        options: TextFieldDensity.values,
        labelBuilder: (value) => value.name,
      ),
      onChanged: (value) {
        debugPrint('Date changed: $value');
      },
    ),
  );
}
