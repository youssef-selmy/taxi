// ignore_for_file: avoid_print

import 'package:better_design_system/molecules/slider/range_slider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRangeSlider)
Widget appRangeSliderUseCase(BuildContext context) {
  final minValue = context.knobs.double.input(
    label: 'Min Value',
    initialValue: 0,
  );
  final maxValue = context.knobs.double.input(
    label: 'Max Value',
    initialValue: 100,
  );
  final effectiveMinValue = (minValue > maxValue) ? maxValue : minValue;
  final effectiveMaxValue = (maxValue < minValue) ? minValue : maxValue;

  final stepSize = context.doubleOrNullInput(
    label: 'Step Size (Optional)',
    initialValue: 1,
  );

  final minAllowedRangeGap = context.knobs.double
      .input(
        label: 'Min Allowed Range Gap',
        initialValue: 10,
        description: 'Minimum allowed gap between start and end values.',
      )
      .clamp(0.0, effectiveMaxValue - effectiveMinValue);

  double initialStartValue = context.knobs.double.slider(
    label: 'Start Value',
    initialValue: (effectiveMinValue +
            (effectiveMaxValue - effectiveMinValue) * 0.25)
        .clamp(effectiveMinValue, effectiveMaxValue),
    min: effectiveMinValue,
    max: effectiveMaxValue,
    divisions:
        (stepSize != null &&
                stepSize > 0 &&
                effectiveMaxValue > effectiveMinValue)
            ? ((effectiveMaxValue - effectiveMinValue) / stepSize)
                .round()
                .clamp(1, 10000)
            : null,
  );

  double initialEndValue = context.knobs.double.slider(
    label: 'End Value',
    initialValue: (effectiveMinValue +
            (effectiveMaxValue - effectiveMinValue) * 0.75)
        .clamp(effectiveMinValue, effectiveMaxValue),
    min: effectiveMinValue,
    max: effectiveMaxValue,
    divisions:
        (stepSize != null &&
                stepSize > 0 &&
                effectiveMaxValue > effectiveMinValue)
            ? ((effectiveMaxValue - effectiveMinValue) / stepSize)
                .round()
                .clamp(1, 10000)
            : null,
  );

  if (initialStartValue > initialEndValue) {
    initialStartValue = initialEndValue;
  }
  if (initialEndValue < initialStartValue + minAllowedRangeGap) {
    initialEndValue = (initialStartValue + minAllowedRangeGap).clamp(
      effectiveMinValue,
      effectiveMaxValue,
    );
    if (initialStartValue > initialEndValue - minAllowedRangeGap) {
      initialStartValue = (initialEndValue - minAllowedRangeGap).clamp(
        effectiveMinValue,
        effectiveMaxValue,
      );
    }
  }
  initialStartValue = initialStartValue.clamp(
    effectiveMinValue,
    effectiveMaxValue,
  );
  initialEndValue = initialEndValue.clamp(effectiveMinValue, effectiveMaxValue);
  if (initialStartValue > initialEndValue) initialStartValue = initialEndValue;

  final currentValues = RangeValues(initialStartValue, initialEndValue);

  return SizedBox(
    width: 600,
    child: AppRangeSlider(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      sublabel: context.knobs.stringOrNull(
        label: 'Sublabel (Optional)',
        initialValue: 'Sublabel',
      ),
      values: currentValues,
      minValue: effectiveMinValue,
      maxValue: effectiveMaxValue,
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
      intermediateStepsCount: context.knobs.int.slider(
        label: 'Intermediate Steps Count',
        initialValue: 3,
        min: 0,
        max: 10,
      ),
      minAllowedRangeGap: minAllowedRangeGap,
      onChanged: (newValues) {
        print('RangeSlider values changed: $newValues');
      },
      onChangeStart: (values) {
        print('RangeSlider drag started at: $values');
      },
      onChangeEnd: (values) {
        print('RangeSlider drag ended at: $values');
      },
    ),
  );
}

extension KnobsExtensionBuildContext on BuildContext {
  String? stringOrNull({
    required String label,
    String? initialValue,
    String? description,
  }) {
    final text = knobs.string(
      label: '$label (Optional)',
      initialValue: initialValue ?? '',
      description: description,
    );
    return text.isEmpty ? null : text;
  }

  double? doubleOrNullInput({
    required String label,
    double? initialValue,
    String? description,
  }) {
    final hasValue = knobs.boolean(
      label: 'Has $label?',
      initialValue: initialValue != null,
    );
    if (!hasValue) return null;
    return knobs.double.input(
      label: label,
      initialValue: initialValue ?? 0,
      description: description,
    );
  }
}
