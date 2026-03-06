import 'package:better_design_system/molecules/charts/bar_sparkline/bar_sparkline.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppBarSparkline)
Widget defaultAppBarSparkline(BuildContext context) {
  final List<ChartSeriesData> data = [
    ChartSeriesData(
      name: 'Taxi',
      points: [
        ChartPoint(name: 'Mon', value: 23),
        ChartPoint(name: 'Tue', value: 23),
        ChartPoint(name: 'Fri', value: 23),
      ],
      color: context.colors.error,
    ),
    ChartSeriesData(
      name: 'Shop',
      points: [
        ChartPoint(name: 'Mon', value: 12),
        ChartPoint(name: 'Tue', value: 23),
        ChartPoint(name: 'Fri', value: 23),
      ],
      color: context.colors.success,
    ),
    ChartSeriesData(
      name: 'Parking',
      points: [
        ChartPoint(name: 'Mon', value: 54),
        ChartPoint(name: 'Tue', value: 23),
        ChartPoint(name: 'Fri', value: 23),
      ],
      color: context.colors.warning,
    ),
  ];
  final showBottomTitle = context.knobs.boolean(
    label: 'Show Bottom Title',
    initialValue: false,
    description: 'show labels on the bottom axis',
  );
  return Center(
    child: SizedBox(
      height: 130,
      width: 200,
      child: AppBarSparkline(
        gridEnabled: context.knobs.boolean(
          label: 'Show Grid',
          initialValue: false,
          description: 'show horizontal grid lines on the chart background.',
        ),
        axis: context.knobs.object.dropdown(
          label: 'Axis',
          options: Axis.values,
          description:
              'Controls chart orientation. In horizontal mode, bars are drawn from left to right; in vertical mode, from bottom to top.',
          initialOption: Axis.vertical,
          labelBuilder: (value) => value.name,
        ),
        type: context.knobs.object.dropdown(
          label: 'Type',
          options: BarChartThinColoredType.values,
          description:
              'Determines how bars are displayed: (stacked) combines values in a single bar, while (grouped) places bars side by side for comparison.',
          initialOption: BarChartThinColoredType.stacked,
          labelBuilder: (value) => value.name,
        ),

        data: data,
        bottomTitleBuilder:
            showBottomTitle ? (value) => value.toUpperCase() : null,
      ),
    ),
  );
}
