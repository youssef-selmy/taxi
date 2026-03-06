import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

FlGridData barChartGridData(BuildContext context) => FlGridData(
  drawVerticalLine: false,
  getDrawingHorizontalLine: (value) =>
      FlLine(color: context.colors.outline, strokeWidth: 1),
);

FlTitlesData barChartStackedTitleData({
  required BuildContext context,
  required List<ChartSeriesData> data,
  String Function(ChartSeriesData)? bottomTitleBuilder,
  String Function(double)? leftTitleBuilder,
  required double leftReservedSize,
}) {
  final grouped = data.groupListsBy((element) => element.name);
  return FlTitlesData(
    leftTitles: leftTitleBuilder == null
        ? const AxisTitles(sideTitles: SideTitles(showTitles: false))
        : AxisTitles(
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
  String Function(double)? leftTitleBuilder,
  required double leftReservedSize,
  double leftTitleAngle = 0,
}) {
  return FlTitlesData(
    leftTitles: leftTitleBuilder == null
        ? const AxisTitles(sideTitles: SideTitles(showTitles: false))
        : AxisTitles(
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

List<Color> activeInactiveColors(BuildContext context) => [
  context.colors.primary,
  context.colors.primary.withValues(alpha: 0.6),
];

const pieChartColors = [
  Color(0xFF0253E8),
  Color(0xFF6C00FF),
  Color(0xFFFF1B68),
];

const vibrantColors = [Color(0xFF36BA98), Color(0xFFE76F51), Color(0xFFF4A261)];
