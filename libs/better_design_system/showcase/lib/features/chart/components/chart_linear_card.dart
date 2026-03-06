import 'package:better_design_system/better_design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';

class ChartLinearCard extends StatelessWidget {
  const ChartLinearCard({super.key});

  @override
  Widget build(BuildContext context) {
    final chartPoints = <ChartPoint>[
      ChartPoint(name: 'Jan', value: 45),
      ChartPoint(name: 'Feb', value: 52),
      ChartPoint(name: 'Mar', value: 58),
      ChartPoint(name: 'Apr', value: 65),
      ChartPoint(name: 'May', value: 72),
      ChartPoint(name: 'Jun', value: 68),
      ChartPoint(name: 'Jul', value: 75),
      ChartPoint(name: 'Aug', value: 82),
      ChartPoint(name: 'Sep', value: 78),
      ChartPoint(name: 'Oct', value: 70),
      ChartPoint(name: 'Nov', value: 62),
      ChartPoint(name: 'Dec', value: 55),
    ];
    return SizedBox(
      width: 1016,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 240,
          child: AppLinearSparkline(
            data: [
              ChartSeriesData(
                points: chartPoints,
                name: 'Chart',
                color: context.colors.secondary,
                isCurved: true,
              ),
            ],
            hasLine: true,
            hasArea: true,
            gridEnabled: true,
            showTooltip: true,
            bottomTitleBuilder: (label) => label,
            leftTitleBuilder: (value) => '\$${value.toInt()}',
            bottomTitleInterval: 1,
            maxY: 100,
            minY: 0,
          ),
        ),
      ),
    );
  }
}
