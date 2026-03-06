import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AppPieChart extends StatelessWidget {
  final Size? size;
  const AppPieChart({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final chartSize = size ?? const Size(160, 160);
    final baseRadius = chartSize.width / 4;

    return SizedBox(
      height: chartSize.height,
      width: chartSize.width,
      child: PieChart(
        PieChartData(
          startDegreeOffset: -90,
          sectionsSpace: 0,
          centerSpaceRadius: chartSize.width / 5,
          sections: [
            PieChartSectionData(
              value: 50,
              color: context.colors.primary,
              showTitle: false,
              radius: baseRadius,
            ),
            PieChartSectionData(
              value: 30,
              color: context.colors.warning,
              showTitle: false,
              radius: baseRadius * 0.85,
            ),
            PieChartSectionData(
              value: 15,
              color: context.colors.tertiary,
              showTitle: false,
              radius: baseRadius * 0.7,
            ),
            PieChartSectionData(
              value: 15,
              color: context.colors.surfaceVariant,
              showTitle: false,
              radius: baseRadius * 0.55,
            ),
          ],
        ),
      ),
    );
  }
}
