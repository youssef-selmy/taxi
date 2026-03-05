import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';

class PieChartOne extends StatelessWidget {
  final List<ChartSeriesData> data;

  const PieChartOne({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        startDegreeOffset: 30,
        sections: data
            .mapIndexed(
              (index, element) => PieChartSectionData(
                color: pieChartColors[index % pieChartColors.length],
                value: element.value.toDouble(),
                showTitle: false,
                radius: 50 - index * 5,
              ),
            )
            .toList(),
      ),
    );
  }
}
