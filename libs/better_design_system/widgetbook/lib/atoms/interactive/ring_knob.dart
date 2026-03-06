import 'package:better_design_system/atoms/interactive/ring_knob.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRingKnob)
Widget appRingKnobUseCase(BuildContext context) {
  return Center(
    child: AppRingKnob(
      state: context.knobs.object.dropdown(
        label: 'State',
        options: KnobState.values,
        initialOption: KnobState.active,
        labelBuilder: (state) => state.name,
      ),
      innerDiameter: context.knobs.double.slider(
        label: 'Inner Diameter',
        initialValue: 10.0,
        min: 5.0,
        max: 45.0,
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
