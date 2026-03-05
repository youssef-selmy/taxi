import 'package:flutter/cupertino.dart';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

FlGridData barChartGridData(BuildContext context) => FlGridData(
  drawVerticalLine: false,
  getDrawingHorizontalLine: (value) =>
      FlLine(color: context.colors.outline, strokeWidth: 0.5),
);

FlTitlesData barChartStackedTitleData({
  required BuildContext context,
  required List<ChartSeriesData> data,
  required String Function(ChartSeriesData) bottomTitleBuilder,
  required String Function(double) leftTitleBuilder,
  required double leftReservedSize,
}) {
  final grouped = data.groupListsBy((element) => element.name);
  return FlTitlesData(
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: leftReservedSize,
        getTitlesWidget: (value, meta) {
          return SideTitleWidget(
            meta: meta,
            child: Text(
              leftTitleBuilder(value),
              style: context.textTheme.labelMedium?.variant(context),
            ),
          );
        },
      ),
    ),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (value.toInt() >= grouped.keys.length) {
            return const SizedBox();
          }
          final title = grouped.keys.elementAt(value.toInt());
          return Text(
            title,
            style: context.textTheme.labelMedium?.variant(context),
          );
        },
      ),
    ),
  );
}

FlTitlesData barChartTitleData({
  required BuildContext context,
  required List<ChartSeriesData> data,
  required String Function(ChartSeriesData) bottomTitleBuilder,
  required String Function(double) leftTitleBuilder,
  required double leftReservedSize,
  double leftTitleAngle = 0,
}) {
  return FlTitlesData(
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: leftReservedSize,
        getTitlesWidget: (value, meta) {
          return SideTitleWidget(
            meta: meta,
            angle: leftTitleAngle,
            child: Text(
              leftTitleBuilder(value),
              style: context.textTheme.labelMedium?.variant(context),
            ),
          );
        },
      ),
    ),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (value.toInt() >= data.length) {
            return const SizedBox();
          }
          final title = bottomTitleBuilder(data.elementAt(value.toInt()));
          return Text(
            title,
            style: context.textTheme.labelMedium?.variant(context),
          );
        },
      ),
    ),
  );
}
