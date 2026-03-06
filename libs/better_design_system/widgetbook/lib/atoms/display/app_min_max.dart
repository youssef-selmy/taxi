import 'package:better_design_system/atoms/display/app_min_max.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

String _defaultFormatter(double value, {bool forMinMax = false}) {
  return value.toStringAsFixed(0);
}

@UseCase(name: 'Default', type: AppMinMax)
Widget appMinMaxUseCase(BuildContext context) {
  final minMaxTextStyle = Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(color: context.colors.onSurfaceVariantLow);

  return Center(
    child: AppMinMax(
      minValue: context.knobs.double.input(label: 'Min Value', initialValue: 0),
      maxValue: context.knobs.double.input(
        label: 'Max Value',
        initialValue: 100,
      ),
      intermediateStepsCount: context.knobs.int.slider(
        label: 'Intermediate Steps Count',
        initialValue: 3,
        min: 0,
        max: 10,
      ),
      textStyle: minMaxTextStyle,
      valueFormatter: _defaultFormatter,
      width: context.knobs.double.slider(
        label: 'Width',
        initialValue: 300,
        min: 100,
        max: 500,
        divisions: 40,
      ),
    ),
  );
}
