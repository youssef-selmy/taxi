import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';

class PieChartThin extends StatelessWidget {
  final List<ChartSeriesData> data;

  const PieChartThin({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 80,
          sections: data
              .mapIndexed(
                (index, element) => PieChartSectionData(
                  color: pieChartThinColors[index % pieChartColors.length],
                  value: element.value.toDouble(),
                  showTitle: false,
                  radius: 15,
                ),
              )
              .toList(),
          sectionsSpace: 2,
          startDegreeOffset: 180,
        ),
      ),
    );
  }
}
