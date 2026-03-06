import 'package:better_design_system/organisms/step_indicator/step_glyph.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppStepGlygh)
Widget defaultStep(BuildContext context) {
  return AppStepGlygh(
    icon: BetterIcons.folder01Outline,
    number: '1',
    status: context.knobs.object.dropdown(
      label: 'Status',
      options: StepIndicatorItemStatus.values,
    ),
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: StepIndicatorItemStyle.values,
    ),
  );
}

@UseCase(name: 'All States', type: AppStepGlygh)
Widget allStatesStep(BuildContext context) {
  return Wrap(
    children:
        StepIndicatorItemStatus.values.map((status) {
          return Wrap(
            children:
                StepIndicatorItemStyle.values.map((style) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppStepGlygh(
                      icon: BetterIcons.folder01Outline,
                      number: '1',
                      status: status,
                      style: style,
                    ),
                  );
                }).toList(),
          );
        }).toList(),
  );
}

@UseCase(name: 'All States (Number)', type: AppStepGlygh)
Widget allStatesNumberStep(BuildContext context) {
  return Wrap(
    children:
        StepIndicatorItemStatus.values.map((status) {
          return Wrap(
            children:
                StepIndicatorItemStyle.values.map((style) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppStepGlygh(
                      icon: null,
                      number: '1',
                      status: status,
                      style: style,
                    ),
                  );
                }).toList(),
          );
        }).toList(),
  );
}
