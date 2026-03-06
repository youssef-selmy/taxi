import 'package:better_design_system/molecules/charts/chart_helper.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';

typedef BetterBarSparkline = AppBarSparkline;

class AppBarSparkline extends StatelessWidget {
  final List<ChartSeriesData> data;
  final String Function(String)? bottomTitleBuilder;
  final String Function(double)? leftTitleBuilder;
  final double leftReservedSize;
  final bool gridEnabled;
  final Axis axis;
  final BarChartThinColoredType type;
  final double barWidth;
  final double? minY;
  final double? maxY;

  const AppBarSparkline({
    super.key,
    required this.data,
    this.bottomTitleBuilder,
    this.leftTitleBuilder,
    this.leftReservedSize = 40,
    this.gridEnabled = false,
    this.type = BarChartThinColoredType.stacked,
    this.axis = Axis.vertical,
    this.barWidth = 8,
    this.minY,
    this.maxY,
  });

  @override
  Widget build(BuildContext context) {
    final days = data
        .expand((e) => e.points.map((p) => p.name))
        .toSet()
        .toList();
    final Map<String, List<ChartSeriesData>> groupedByDay = {
      for (var day in days)
        day: data.map((series) {
          final point = series.points.firstWhere(
            (p) => p.name == day,
            orElse: () => ChartPoint(name: day, value: 0),
          );
          return ChartSeriesData(
            name: series.name,
            color: series.color,
            points: [point],
          );
        }).toList(),
    };

    return RotatedBox(
      quarterTurns: axis == Axis.horizontal ? -3 : 0,
      child: BarChart(
        BarChartData(
          minY: minY,
          maxY: maxY,
          titlesData: bottomTitleBuilder == null
              ? const FlTitlesData(show: false)
              : FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= days.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          bottomTitleBuilder!(days[index]),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: leftTitleBuilder == null
                      ? const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        )
                      : AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: leftReservedSize,
                            getTitlesWidget: (value, _) => Text(
                              leftTitleBuilder!(value),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                ),

          gridData: gridEnabled
              ? barChartGridData(context)
              : const FlGridData(show: false),
          barTouchData: const BarTouchData(enabled: false),
          borderData: FlBorderData(show: false),
          alignment: BarChartAlignment.spaceAround,

          barGroups: groupedByDay.keys.mapIndexed((index, day) {
            final entries = groupedByDay[day]!;
            return BarChartGroupData(
              x: index,
              barRods: type == BarChartThinColoredType.stacked
                  ? [
                      BarChartRodData(
                        rodStackItems: getBarChartRodStackItems(entries),
                        width: barWidth,
                        borderRadius: BorderRadius.circular(5),
                        toY: entries.fold(
                          0,
                          (sum, e) => sum + e.points.first.value,
                        ),
                        color: null,
                      ),
                    ]
                  : entries
                        .mapIndexed(
                          (i, e) => BarChartRodData(
                            toY: e.points.first.value,
                            width: barWidth,
                            borderRadius: BorderRadius.circular(5),
                            color: e.color,
                          ),
                        )
                        .toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

enum BarChartThinColoredType { stacked, grouped }

List<BarChartRodStackItem> getBarChartRodStackItems(
  List<ChartSeriesData> data,
) {
  double startY = 0.0;
  return data.map((series) {
    final value = series.points.first.value;
    final color = series.color;
    final item = BarChartRodStackItem(startY, startY + value, color);
    startY += value;
    return item;
  }).toList();
}
