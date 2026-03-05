import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/bar_chart_common.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class BarChartThin extends StatelessWidget {
  final List<ChartSeriesData> data;
  final String Function(ChartSeriesData) bottomTitleBuilder;
  final String Function(double) leftTitleBuilder;
  final double leftReservedSize;

  const BarChartThin({
    super.key,
    required this.data,
    required this.bottomTitleBuilder,
    required this.leftTitleBuilder,
    this.leftReservedSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    final double max = data.isEmpty
        ? 1
        : data
                  .map((e) => e.value)
                  .reduce(
                    (value, element) => value > element ? value : element,
                  ) *
              1.1;
    return BarChart(
      BarChartData(
        titlesData: barChartTitleData(
          context: context,
          data: data,
          bottomTitleBuilder: bottomTitleBuilder,
          leftTitleBuilder: leftTitleBuilder,
          leftReservedSize: leftReservedSize,
        ),
        gridData: barChartGridData(context),
        barTouchData: BarTouchData(enabled: false),
        borderData: FlBorderData(show: false),
        alignment: BarChartAlignment.spaceAround,
        barGroups: data
            .mapIndexed(
              (index, e) => BarChartGroupData(
                x: index,
                groupVertically: true,
                barRods: [
                  BarChartRodData(
                    width: 16,
                    borderRadius: BorderRadius.circular(60),
                    rodStackItems: [
                      BarChartRodStackItem(0, e.value, context.colors.primary),
                      BarChartRodStackItem(
                        e.value,
                        max,
                        context.colors.surfaceVariant,
                      ),
                    ],
                    toY: e.value,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: context.colors.surfaceVariant,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
