import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppLinearSparkline)
Widget defaultAppLinearSparkline(BuildContext context) {
  final List<ChartSeriesData> data = [
    ChartSeriesData(
      name: 'Taxi',
      points: [
        ChartPoint(name: 'Mon', value: 20),
        ChartPoint(name: 'Tue', value: 24),
        ChartPoint(name: 'Fri', value: 22),
      ],
      color: context.colors.error,
      isCurved: context.knobs.boolean(
        label: 'Curved',
        initialValue: false,
        description:
            'chart lines should be drawn with smooth curves instead of straight lines.',
      ),
    ),
    ChartSeriesData(
      name: 'Shop',
      points: [
        ChartPoint(name: 'Mon', value: 12),
        ChartPoint(name: 'Tue', value: 19),
        ChartPoint(name: 'Fri', value: 20),
      ],
      color: context.colors.success,
      isCurved: context.knobs.boolean(
        label: 'Curved',
        initialValue: false,
        description:
            'chart lines should be drawn with smooth curves instead of straight lines.',
      ),
    ),
    ChartSeriesData(
      name: 'Parking',
      points: [
        ChartPoint(name: 'Mon', value: 16),
        ChartPoint(name: 'Tue', value: 20),
        ChartPoint(name: 'Fri', value: 18),
      ],
      color: context.colors.warning,
      isCurved: context.knobs.boolean(
        label: 'Curved',
        initialValue: false,
        description:
            'chart lines should be drawn with smooth curves instead of straight lines.',
      ),
    ),
  ];
  final showBottomTitle = context.knobs.boolean(
    label: 'Show Bottom Title',
    initialValue: false,
    description: 'show labels on the bottom axis',
  );
  final hasTooltip = context.knobs.boolean(
    label: 'Show Tooltip',
    initialValue: true,
    description: 'show tooltip on the chart',
  );
  return Padding(
    padding: const EdgeInsets.all(100.0),
    child: AppLinearSparkline(
      gridEnabled: context.knobs.boolean(
        label: 'Show Grid',
        initialValue: false,
        description: 'show horizontal grid lines on the chart background.',
      ),

      hasLine: context.knobs.boolean(
        label: 'Has Line',
        initialValue: true,
        description:
            'Controls whether the main connecting line between chart points is displayed.',
      ),
      hasArea: context.knobs.boolean(
        label: 'Has Area',
        initialValue: true,
        description:
            'Controls whether the area below the main line is filled with a color gradient.',
      ),
      showTooltip: hasTooltip,
      data: data,
      bottomTitleBuilder:
          showBottomTitle ? (value) => value.toUpperCase() : null,
    ),
  );
}

@UseCase(name: 'Single', type: AppLinearSparkline)
Widget singleAppLinearSparkline(BuildContext context) {
  final List<ChartSeriesData> data = [
    ChartSeriesData(
      name: 'Taxi',
      points: [
        ChartPoint(name: 'Mon', value: 20),
        ChartPoint(name: 'Tue', value: 24),
        ChartPoint(name: 'Fri', value: 22),
      ],
      color: context.colors.error,
      isCurved: context.knobs.boolean(
        label: 'Curved',
        initialValue: false,
        description:
            'chart lines should be drawn with smooth curves instead of straight lines.',
      ),
    ),
  ];
  final showBottomTitle = context.knobs.boolean(
    label: 'Show Bottom Title',
    initialValue: false,
    description: 'show labels on the bottom axis',
  );
  final hasTooltip = context.knobs.boolean(
    label: 'Show Tooltip',
    initialValue: true,
    description: 'show tooltip on the chart',
  );
  return Center(
    child: SizedBox(
      width: 120,
      height: 46,
      child: AppLinearSparkline(
        gridEnabled: context.knobs.boolean(
          label: 'Show Grid',
          initialValue: false,
          description: 'show horizontal grid lines on the chart background.',
        ),

        hasLine: context.knobs.boolean(
          label: 'Has Line',
          initialValue: true,
          description:
              'Controls whether the main connecting line between chart points is displayed.',
        ),
        hasArea: context.knobs.boolean(
          label: 'Has Area',
          initialValue: true,
          description:
              'Controls whether the area below the main line is filled with a color gradient.',
        ),
        showTooltip: hasTooltip,
        data: data,
        bottomTitleBuilder:
            showBottomTitle ? (value) => value.toUpperCase() : null,
      ),
    ),
  );
}
