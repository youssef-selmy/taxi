// ignore_for_file: avoid_print

import 'package:better_design_system/molecules/slider/slider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

@UseCase(name: 'Default', type: AppSlider)
Widget appSingleKnobSliderUseCase(BuildContext context) {
  final minValue = context.knobs.double.input(
    label: 'Min Value',
    initialValue: 0,
  );
  final maxValue = context.knobs.double.input(
    label: 'Max Value',
    initialValue: 100,
  );
  final stepSize = context.knobs.doubleOrNull.input(
    label: 'Step Size (Optional)',
    initialValue: 1,
  );

  double initialSliderValue = 50;
  if (initialSliderValue < minValue) initialSliderValue = minValue;
  if (initialSliderValue > maxValue) initialSliderValue = maxValue;
  if (stepSize != null && stepSize > 0 && maxValue > minValue) {
    final double relativeValue = initialSliderValue - minValue;
    final double steps = (relativeValue / stepSize).round().toDouble();
    initialSliderValue = minValue + (steps * stepSize);
    initialSliderValue = initialSliderValue.clamp(minValue, maxValue);
  } else {
    initialSliderValue = initialSliderValue.clamp(minValue, maxValue);
  }

  int? divisions;
  if (stepSize != null && stepSize > 0 && maxValue > minValue) {
    final calculatedDivisions = ((maxValue - minValue) / stepSize).round();
    if (calculatedDivisions > 0) {
      divisions = calculatedDivisions.clamp(1, 10000);
    }
  }
  if (divisions == null && maxValue > minValue) {
    divisions = 100;
  }

  return SizedBox(
    width: 600,
    child: AppSlider(
      intermediateStepsCount: context.knobs.int.slider(
        label: 'Intermediate Steps Count for Min/Max Display',
        initialValue: 0,
        min: 0,
        max: 10,
        divisions: 10,
      ),
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      sublabel: context.knobs.stringOrNull(
        label: 'Sublabel (Optional)',
        initialValue: 'Sublabel',
      ),
      value: context.knobs.double.slider(
        label: 'Value',
        initialValue: initialSliderValue,
        min: minValue,
        max: maxValue,
        divisions: divisions,
      ),
      minValue: minValue,
      maxValue: maxValue,
      stepSize: stepSize,
      isDisabled: context.knobs.boolean(
        label: 'Is Disabled',
        initialValue: false,
      ),
      semanticColor: context.knobs.object.dropdown(
        label: 'Semantic Color',
        options: SemanticColor.values,
        initialOption: SemanticColor.primary,
        labelBuilder: (color) => color.name,
      ),
      knobType: context.knobs.object.dropdown(
        label: 'Knob Type',
        options: SliderKnobType.values,
        initialOption: SliderKnobType.circle,
        labelBuilder: (type) => type.name,
      ),
      showValueTooltip: context.knobs.boolean(
        label: 'Show Value Tooltip',
        initialValue: true,
      ),
      valueTooltipAlignment: context.knobs.object.dropdown(
        label: 'Tooltip Alignment',
        options: TooltipAlignment.values,
        initialOption: TooltipAlignment.top,
        labelBuilder: (alignment) => alignment.name,
      ),

      valueTextFormatter: (value) {
        return '${value.round()}';
      },
      onChanged: (value) {
        print('Slider value changed: $value');
      },
      onChangeStart: (value) {
        print('Slider drag started at: $value');
      },
      onChangeEnd: (value) {
        print('Slider drag ended at: $value');
      },
    ),
  );
}

// two expanded widgets in a row
@UseCase(name: 'Expanded', type: AppSlider)
Widget appRangeSliderUseCase(BuildContext context) {
  final minValue = context.knobs.double.input(
    label: 'Min Value',
    initialValue: 0,
  );
  final maxValue = context.knobs.double.input(
    label: 'Max Value',
    initialValue: 100,
  );
  final stepSize = context.knobs.doubleOrNull.input(
    label: 'Step Size (Optional)',
    initialValue: 1,
  );
  RangeValues initialSliderValue = const RangeValues(20, 80);
  if (initialSliderValue.start < minValue ||
      initialSliderValue.end > maxValue ||
      initialSliderValue.start > initialSliderValue.end) {
    initialSliderValue = RangeValues(minValue, maxValue);
  }
  if (stepSize != null && stepSize > 0 && maxValue > minValue) {
    final double relativeStartValue = initialSliderValue.start - minValue;
    final double startSteps =
        (relativeStartValue / stepSize).round().toDouble();
    double newStartValue = minValue + (startSteps * stepSize);
    newStartValue = newStartValue.clamp(minValue, maxValue);
    final double relativeEndValue = initialSliderValue.end - minValue;
    final double endSteps = (relativeEndValue / stepSize).round().toDouble();
    double newEndValue = minValue + (endSteps * stepSize);
    newEndValue = newEndValue.clamp(minValue, maxValue);
    if (newStartValue <= newEndValue) {
      initialSliderValue = RangeValues(newStartValue, newEndValue);
    } else {
      initialSliderValue = RangeValues(minValue, maxValue);
    }
  } else {
    initialSliderValue = RangeValues(
      initialSliderValue.start.clamp(minValue, maxValue),
      initialSliderValue.end.clamp(minValue, maxValue),
    );
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 500,
        child: LayoutGrid(
          columnSizes: [1.fr, 1.fr],
          rowSizes: [auto],
          children: [
            AppSlider(
              label: 'Start',
              value: context.knobs.double.slider(
                label: 'Start Value',
                initialValue: initialSliderValue.start,
                min: minValue,
                max: maxValue,
                divisions:
                    stepSize != null && stepSize > 0 && maxValue > minValue
                        ? ((maxValue - minValue) / stepSize).round().clamp(
                          1,
                          10000,
                        )
                        : (maxValue > minValue ? 100 : null),
              ),
              minValue: minValue,
              maxValue: maxValue,
              stepSize: stepSize,
              onChanged: (value) {
                print('Start Slider value changed: $value');
              },
            ),
            AppSlider(
              label: 'End',
              value: context.knobs.double.slider(
                label: 'End Value',
                initialValue: initialSliderValue.end,
                min: minValue,
                max: maxValue,
                divisions:
                    stepSize != null && stepSize > 0 && maxValue > minValue
                        ? ((maxValue - minValue) / stepSize).round().clamp(
                          1,
                          10000,
                        )
                        : (maxValue > minValue ? 100 : null),
              ),
              minValue: minValue,
              maxValue: maxValue,
              stepSize: stepSize,
              onChanged: (value) {
                print('End Slider value changed: $value');
              },
            ),
          ],
        ),
      ),
    ],
  );
}
