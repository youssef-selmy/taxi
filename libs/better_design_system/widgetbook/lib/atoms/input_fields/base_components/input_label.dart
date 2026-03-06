import 'package:better_design_system/atoms/input_fields/base_components/input_label.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppInputLabel)
Widget defaultInputLabel(BuildContext context) {
  final hasHelpText = context.knobs.boolean(
    label: 'Has Help Text',
    description: 'Does this field have help text?',
    initialValue: false,
  );
  return AppInputLabel(
    label: 'Title',
    sublabel: 'Details',
    helpText:
        hasHelpText ? "The help text provides additional information." : null,
    isRequired: context.knobs.boolean(
      label: 'Is Required',
      description: 'Is this field required?',
      initialValue: false,
    ),
    isDisabled: context.knobs.boolean(
      label: 'Is Disabled',
      description: 'Is this field disabled?',
      initialValue: false,
    ),
  );
}
