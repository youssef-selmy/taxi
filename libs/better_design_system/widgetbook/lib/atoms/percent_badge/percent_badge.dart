import 'package:better_design_system/atoms/percent_badge/percent_badge.dart';

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppPercentBadge)
Widget defaultAppPercentBadge(BuildContext context) {
  return AppPercentBadge(
    percent: context.knobs.double.slider(
      label: 'Percent',
      initialValue: 30,
      min: -100,
      max: 100,
      description:
          'Percentage value to display. Negative for decrease, positive for increase.',
    ),
  );
}
