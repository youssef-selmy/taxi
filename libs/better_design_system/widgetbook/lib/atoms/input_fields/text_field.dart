import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';

@UseCase(name: 'Default', type: AppTextField)
Widget defaultAppTextField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppTextField(
      label: 'Title',
      labelHelpText: context.knobs.stringOrNull(
        label: 'Label Help Text',
        initialValue: 'Insert help text here.',
      ),
      sublabel: context.knobs.stringOrNull(
        label: 'Sublabel',
        initialValue: 'Sublabel',
      ),
      isRequired: context.knobs.boolean(
        label: 'Is Required',
        initialValue: true,
      ),
      density: context.knobs.object.dropdown(
        label: 'isDense',
        options: TextFieldDensity.values,
        initialOption: TextFieldDensity.responsive,
        labelBuilder: (TextFieldDensity value) => value.name,
      ),
      helpText: context.knobs.stringOrNull(
        label: 'Help Text',
        initialValue: 'Insert text here to help users.',
      ),
      hint: context.knobs.stringOrNull(label: 'Hint', initialValue: 'Hint'),
      helpTextColor: context.knobs.object.dropdown(
        label: 'Help Text Color',
        options: SemanticColor.values,
        labelBuilder: (SemanticColor value) => value.name,
      ),
      prefixIcon: Icon(BetterIcons.lockPasswordOutline),
      suffixIcon: Icon(BetterIcons.eyeOutline),
    ),
  );
}

@UseCase(name: 'Disabled', type: AppTextField)
Widget disabledAppTextField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppTextField(
      label: 'Title',
      isRequired: true,
      density: context.knobs.object.dropdown(
        label: 'isDense',
        options: TextFieldDensity.values,
        initialOption: TextFieldDensity.responsive,
        labelBuilder: (TextFieldDensity value) => value.name,
      ),
      helpText: "Insert text here to help users.",
      hint: "Hint",
      prefixIcon: Icon(BetterIcons.lockPasswordOutline),
      suffixIcon: Icon(BetterIcons.eyeOutline),
      isDisabled: true,
    ),
  );
}

@UseCase(name: 'Filled', type: AppTextField)
Widget filledAppTextField(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppTextField(
      label: 'Title',
      isRequired: true,
      density: context.knobs.object.dropdown(
        label: 'isDense',
        options: TextFieldDensity.values,
        initialOption: TextFieldDensity.responsive,
        labelBuilder: (TextFieldDensity value) => value.name,
      ),
      helpText: "Insert text here to help users.",
      hint: "Hint",
      prefixIcon: Icon(BetterIcons.lockPasswordOutline),
      suffixIcon: Icon(BetterIcons.eyeOutline),
      isFilled: true,
    ),
  );
}
