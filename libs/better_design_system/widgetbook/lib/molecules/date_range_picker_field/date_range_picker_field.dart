import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_design_system/molecules/date_range_picker_field/date_range_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDateRangePickerField)
Widget appAppDateRangePickerField(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(height: 100),
      SizedBox(
        width: 362,
        child: AppDateRangePickerField(
          // activeDate: (DateTime(2025, 5, 22), DateTime(2025, 5, 27)),
          datePickerTitle: 'Select Date',
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
            options: DateRangePickerFieldStyle.values,
            labelBuilder: (value) => value.name,
          ),
          label: context.knobs.string(
            label: 'Label',
            initialValue: 'Birth Date',
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
