import 'package:better_design_system/atoms/input_fields/base_components/input_hint.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppInputHint)
Widget defaultInputHint(BuildContext context) {
  return AppInputHint(
    text: 'Enter Password',
    color: context.knobs.object.dropdown(
      label: 'Color',
      options: SemanticColor.values,
      initialOption: SemanticColor.neutral,
    ),
  );
}
