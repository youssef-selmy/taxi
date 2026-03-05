import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/bar_chart_common.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class LineChartOne<T> extends StatelessWidget {
  final List<ChartSeriesData<T>> data;
  final String Function(ChartSeriesData) bottomTitleBuilder;
  final String Function(double) leftTitleBuilder;
  final String Function(T) groupLabelBuilder;

  const LineChartOne({
    super.key,
    required this.data,
    required this.bottomTitleBuilder,
    required this.leftTitleBuilder,
    required this.groupLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = data.groupListsBy((element) => element.groupBy);
    return LineChart(
      LineChartData(
        gridData: barChartGridData(context),
        titlesData: barChartStackedTitleData(
          context: context,
          data: data,
          bottomTitleBuilder: bottomTitleBuilder,
          leftTitleBuilder: leftTitleBuilder,
          leftReservedSize: 40,
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => context.colors.surface,
            tooltipBorder: BorderSide(color: context.colors.outline),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((e) {
                final label = groupLabelBuilder(
                  grouped.keys.elementAt(e.barIndex) as T,
                );
                final series =
                    grouped[grouped.keys.elementAt(e.barIndex)
                        as T]![e.spotIndex];
                return LineTooltipItem(
                  "$label: ${series.value.toInt()}",
                  context.textTheme.labelMedium!,
                );
              }).toList();
            },
          ),
          touchCallback: (event, touchResponse) {},
          handleBuiltInTouches: true,
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: grouped.keys
            .mapIndexed(
              (index, key) => LineChartBarData(
                spots: grouped[key]!
                    .mapIndexed((index, e) => FlSpot(index.toDouble(), e.value))
                    .toList(),
                isCurved: true,
                color: activeInactiveColors(
                  context,
                )[index % activeInactiveColors(context).length],
                barWidth: 5,
                preventCurveOverShooting: true,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
                dotData: const FlDotData(show: false),
              ),
            )
            .toList(),
      ),
    );
  }
}
