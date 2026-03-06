import 'package:better_design_system/atoms/input_fields/date_range_input/date_range_input.dart';
import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDateRangeInput)
Widget appAppDateInput(BuildContext context) {
  return SizedBox(
    width: 362,
    child: AppDateRangeInput(
      // initialValue: (DateTime.now(), DateTime(2030)),
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

      density: context.knobs.object.dropdown(
        label: 'Density',
        options: TextFieldDensity.values,
        labelBuilder: (value) => value.name,
      ),
      onChanged: (value) {},
    ),
  );
}
