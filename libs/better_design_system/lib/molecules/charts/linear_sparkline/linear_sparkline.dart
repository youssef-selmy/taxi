import 'package:better_design_system/molecules/charts/chart_helper.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

export '../chart_series_data.dart';

typedef BetterLinearSparkline = AppLinearSparkline;

class AppLinearSparkline extends StatelessWidget {
  final List<ChartSeriesData> data;
  final String Function(String)? bottomTitleBuilder;
  final String Function(double)? leftTitleBuilder;
  final bool gridEnabled;
  final bool hasLine;
  final bool hasArea;
  final bool showTooltip;
  final int? bottomTitleInterval;
  final double? minY;
  final double? maxY;

  const AppLinearSparkline({
    super.key,
    required this.data,
    this.bottomTitleBuilder,
    this.leftTitleBuilder,
    this.gridEnabled = false,

    this.hasLine = true,
    this.hasArea = true,
    this.showTooltip = true,
    this.bottomTitleInterval,
    this.minY,
    this.maxY,
  }) : assert(
         hasLine || hasArea,
         'At least one of hasLine or hasArea must be true. '
         'If both are false, nothing will be rendered on the chart.',
       );

  @override
  Widget build(BuildContext context) {
    final allPointNames = data
        .expand((series) => series.points.map((point) => point.name))
        .toSet()
        .toList();

    final seriesSpots = data.map((series) {
      return allPointNames.mapIndexed((index, name) {
        final point = series.points.firstWhereOrNull((p) => p.name == name);
        return FlSpot(index.toDouble(), point?.value ?? 0);
      }).toList();
    }).toList();

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: gridEnabled
            ? barChartGridData(context)
            : const FlGridData(show: false),

        titlesData: bottomTitleBuilder == null
            ? const FlTitlesData(show: false)
            : FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    interval: bottomTitleInterval?.toDouble(),
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < allPointNames.length) {
                        final label = bottomTitleBuilder!(allPointNames[index]);
                        return Text(
                          label,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: leftTitleBuilder != null ? true : false,
                    reservedSize: 44,
                    getTitlesWidget: (value, meta) => Text(
                      leftTitleBuilder?.call(value) ?? value.toString(),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),

        lineTouchData: LineTouchData(
          enabled: showTooltip,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => context.colors.surface,
            tooltipBorder: BorderSide(color: context.colors.outline),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((e) {
                final seriesIndex = e.barIndex;
                final spotIndex = e.spotIndex;
                final series = data[seriesIndex];
                final pointName = allPointNames[spotIndex];
                final point = series.points.firstWhereOrNull(
                  (p) => p.name == pointName,
                );
                final value = point?.value ?? 0;
                return LineTooltipItem(
                  "${series.name} - $pointName: ${value.toInt()}",
                  context.textTheme.labelMedium!,
                );
              }).toList();
            },
          ),
          touchCallback: (event, touchResponse) {},
          handleBuiltInTouches: true,
        ),

        borderData: FlBorderData(show: false),

        lineBarsData: seriesSpots
            .mapIndexed(
              (index, spots) => LineChartBarData(
                spots: spots,
                isCurved: data[index].isCurved,
                color: data[index].color,
                barWidth: hasLine ? 3 : 0,
                preventCurveOverShooting: true,
                isStrokeCapRound: true,
                belowBarData: hasArea
                    ? BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: hasLine
                              ? [
                                  data[index].color.withValues(alpha: 0.1),
                                  data[index].color.withValues(alpha: 0.0),
                                ]
                              : [
                                  data[index].color,
                                  data[index].color.withValues(alpha: 0.6),
                                ],
                        ),
                      )
                    : BarAreaData(show: false),
                dotData: const FlDotData(show: false),
              ),
            )
            .toList(),
      ),
    );
  }
}
