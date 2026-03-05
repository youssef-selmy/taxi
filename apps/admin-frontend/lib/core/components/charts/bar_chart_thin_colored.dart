import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/bar_chart_common.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_stacked.dart';
import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';

class BarChartThinColored extends StatelessWidget {
  final List<ChartSeriesData> data;
  final String Function(ChartSeriesData) bottomTitleBuilder;
  final String Function(double) leftTitleBuilder;
  final double leftReservedSize;

  const BarChartThinColored({
    super.key,
    required this.data,
    required this.bottomTitleBuilder,
    required this.leftTitleBuilder,
    this.leftReservedSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    // final double max =
    //     data.isEmpty ? 1 : data.map((e) => e.value).reduce((value, element) => value > element ? value : element) * 1.1;
    final grouped = data.groupListsBy((element) => element.groupBy);
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
        barGroups: grouped.keys
            .mapIndexed(
              (index, key) => BarChartGroupData(
                x: index,
                // barRods: grouped[key]?.mapIndexed((index, element) {
                //   return BarChartRodData(
                //     width: 10,
                //     borderRadius: BorderRadius.circular(5),
                //     color: vibrantColors[index % (vibrantColors.length - 1)],
                //     toY: grouped[key]?.map((e) => e.value).reduce((value, element) => value + element) ?? 0,
                //   );
                // }).toList(),
                barRods: [
                  BarChartRodData(
                    rodStackItems: getBarChartRodStackItems(
                      grouped[key] ?? [],
                      vibrantColors,
                    ),
                    width: 10,
                    borderRadius: BorderRadius.circular(5),
                    toY:
                        grouped[key]
                            ?.map((e) => e.value)
                            .reduce((value, element) => value + element) ??
                        0,
                    color: vibrantColors[index % (vibrantColors.length - 1)],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
