import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/molecules/date_picker_field/date_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDatePickerField)
Widget appAppDatePickerField(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(height: 100),
      SizedBox(
        width: 362,
        child: AppDatePickerField(
          validator: (p0) {
            if (p0 == null) {
              return 'Invalid Date';
            }
            return null;
          },
          title: 'Select Date',
          onChanged: (value) {},
          pickTime: context.knobs.boolean(
            label: 'Pick Time',
            initialValue: false,
          ),
          events: [
            DateTime(2025, 5, 26),
            DateTime(2025, 5, 31),
            DateTime(2025, 5, 28),
          ],
          style: context.knobs.object.dropdown(
            label: 'Style',
            options: DatePickerFieldStyle.values,
            labelBuilder: (value) => value.name,
          ),
          label: context.knobs.string(
            label: 'Label',
            initialValue: 'Select Range',
          ),

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
          isFilled: context.knobs.boolean(label: 'Filled', initialValue: false),
          isDisabled: context.knobs.boolean(
            label: 'Disabled',
            initialValue: false,
          ),
          density: context.knobs.object.dropdown(
            label: 'Density',
            options: TextFieldDensity.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
    ],
  );
}
