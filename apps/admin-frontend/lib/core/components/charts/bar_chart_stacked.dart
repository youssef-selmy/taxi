import 'dart:core';

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/bar_chart_common.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';

class BarChartStacked extends StatelessWidget {
  final List<ChartSeriesData> data;
  final String Function(ChartSeriesData) bottomTitleBuilder;
  final String Function(double) leftTitleBuilder;
  final double leftReservedSize;

  const BarChartStacked({
    super.key,
    required this.data,
    required this.bottomTitleBuilder,
    required this.leftTitleBuilder,
    this.leftReservedSize = 44,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = data.groupListsBy((element) => element.name);
    return BarChart(
      BarChartData(
        titlesData: barChartStackedTitleData(
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
        // group per date
        barGroups: grouped.keys
            .mapIndexed(
              (index, key) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    rodStackItems: getBarChartRodStackItems(
                      grouped[key] ?? [],
                      pieChartColors,
                    ),
                    width: 24,
                    borderRadius: BorderRadius.circular(5),
                    toY:
                        grouped[key]
                            ?.map((e) => e.value)
                            .reduce((value, element) => value + element) ??
                        0,
                    color: pieChartColors[0],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

List<BarChartRodStackItem> getBarChartRodStackItems(
  List<ChartSeriesData> data,
  List<Color> colors,
) {
  double startY = 0.0;
  final grouped = data.groupListsBy((element) => element.name);
  return grouped.keys.mapIndexed((index, app) {
    final totalRevenue = grouped[app]!
        .map((e) => e.value)
        .reduce((value, element) => value + element);
    startY += totalRevenue;
    return BarChartRodStackItem(
      startY - totalRevenue,
      startY,
      colors[index % pieChartColors.length],
    );
  }).toList();
}
