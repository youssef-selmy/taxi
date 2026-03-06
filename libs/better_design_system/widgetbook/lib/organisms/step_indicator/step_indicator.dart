import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:better_design_system/organisms/step_indicator/vertical_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppHorizontalStepIndicator)
Widget defaultStepIndicator(BuildContext context) {
  return AppHorizontalStepIndicator(
    items: [
      StepIndicatorItem(label: 'Step 1', description: 'Description', value: 1),
      StepIndicatorItem(label: 'Step 2', description: 'Description', value: 2),
      StepIndicatorItem(label: 'Step 3', description: 'Description', value: 3),
    ],
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: StepIndicatorItemStyle.values,
      labelBuilder: (value) => value.name,
    ),
    connectorStyle: context.knobs.object.dropdown(
      label: 'Connector Style',
      options: ConnectorStyle.values,
      labelBuilder: (value) => value.name,
    ),
    selectedStep: context.knobs.int.slider(
      label: 'Selected Step',
      min: 1,
      max: 3,
      initialValue: 1,
    ),
  );
}

@UseCase(name: 'VerticalStepIndicator', type: AppVerticalStepIndicator)
Widget verticalStepIndicator(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 200,
        child: AppVerticalStepIndicator(
          items: [
            StepIndicatorItem(
              label: 'Step 1',
              description: 'Description',
              value: 1,
            ),
            StepIndicatorItem(
              label: 'Step 2',
              description: 'Description',
              value: 2,
            ),
            StepIndicatorItem(
              label: 'Step 3',
              description: 'Description',
              value: 3,
            ),
          ],
          style: context.knobs.object.dropdown(
            label: 'Style',
            options: StepIndicatorItemStyle.values,
            labelBuilder: (value) => value.name,
          ),
          connectorStyle: context.knobs.object.dropdown(
            label: 'Connector Style',
            options: ConnectorStyle.values,
            labelBuilder: (value) => value.name,
          ),
          selectedStep: context.knobs.int.slider(
            label: 'Selected Step',
            min: 1,
            max: 3,
            initialValue: 1,
          ),
        ),
      ),
    ],
  );
}
