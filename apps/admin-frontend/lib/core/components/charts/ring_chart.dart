import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class RingChart extends StatelessWidget {
  final List<ChartSeriesData> data;

  const RingChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final max = data.isEmpty
        ? 1
        : data
                  .map((e) => e.value)
                  .reduce(
                    (value, element) => value > element ? value : element,
                  ) *
              1.1;
    final totalCount = data.isEmpty
        ? 0
        : data.map((e) => e.value).reduce((value, element) => value + element);
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.tr.total,
                style: context.textTheme.labelMedium
                    ?.copyWith(fontSize: 13)
                    .variant(context),
              ),
              Text(totalCount.toString(), style: context.textTheme.titleMedium),
            ],
          ),
        ),
        for (var i = 0; i < data.length; i++)
          Positioned.fill(
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                startDegreeOffset: 270,
                centerSpaceRadius: 60 + i * 20,
                sections: [
                  PieChartSectionData(
                    radius: 15,
                    showTitle: false,
                    value: data[i].value,
                    color: data[i].color,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    radius: 15,
                    value: max - data[i].value,
                    color: context.colors.outline,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
