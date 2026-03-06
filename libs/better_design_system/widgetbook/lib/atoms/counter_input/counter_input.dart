import 'package:better_design_system/atoms/buttons/soft_button.dart';
import 'package:better_design_system/atoms/input_fields/counter_input/counter_input.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppCounterInput)
Widget appCounterInput(BuildContext context) {
  final hasError = context.knobs.boolean(label: 'Error', initialValue: false);

  final showHelperText = context.knobs.boolean(
    label: 'Show Helper Text',
    description: 'Show helper text below the input field',
    initialValue: true,
  );

  return SizedBox(
    width: 352,
    child: AppCounterInput(
      label: context.knobs.title,
      sublabel: context.knobs.subLabel,
      helpText: showHelperText ? 'Insert text here to help users.' : null,
      isDisabled: context.knobs.isDisabled,
      isFilled: context.knobs.isFilled,
      size: context.knobs.object.dropdown(
        label: 'Size',
        options: CounterInputSize.values,
        labelBuilder: (value) => value.name,
      ),
      validator: (p0) {
        if (hasError) {
          return 'Error';
        }
        return null;
      },

      max: context.knobs.int.input(
        label: 'Max',
        description: 'Maximum value',
        initialValue: 100,
      ),
      helpTextColor: context.knobs.object.dropdown(
        label: 'Help Text Color',
        options: SemanticColor.values,
        labelBuilder: (value) => value.name,
        description: 'Color of the help text',
        initialOption: SemanticColor.neutral,
      ),
      initialValue: 0,
    ),
  );
}
