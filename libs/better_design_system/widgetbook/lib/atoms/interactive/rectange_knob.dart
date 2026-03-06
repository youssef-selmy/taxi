import 'package:better_design_system/atoms/interactive/rectangle_knob.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRectangleKnob)
Widget appRectangleKnobUseCase(BuildContext context) {
  return Center(
    child: AppRectangleKnob(
      state: context.knobs.object.dropdown(
        label: 'State',
        options: KnobState.values,
        initialOption: KnobState.active,
        labelBuilder: (state) => state.name,
      ),
      width: context.knobs.double.slider(
        label: 'Width',
        initialValue: 4.0,
        min: 2.0,
        max: 20.0,
        divisions: 18,
      ),
      height: context.knobs.double.slider(
        label: 'Height',
        initialValue: 22.0,
        min: 10.0,
        max: 50.0,
        divisions: 40,
      ),
      semanticColor: context.knobs.object.dropdown(
        label: 'Semantic Color',
        options: SemanticColor.values,
        initialOption: SemanticColor.primary,
        labelBuilder: (color) => color.name,
      ),
    ),
  );
}
