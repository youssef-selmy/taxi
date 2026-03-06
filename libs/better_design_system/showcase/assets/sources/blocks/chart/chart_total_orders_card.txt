import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/widgets.dart';

class ChartTotalOrdersCard extends StatelessWidget {
  const ChartTotalOrdersCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartSeriesData> data = [
      ChartSeriesData(
        name: 'statistics',
        points: [
          ChartPoint(name: 'Jan', value: 3000),
          ChartPoint(name: 'Feb', value: 3050),
          ChartPoint(name: 'Mar', value: 3020),
          ChartPoint(name: 'Apr', value: 3070),
          ChartPoint(name: 'May', value: 3040),
          ChartPoint(name: 'Jun', value: 3090),
          ChartPoint(name: 'Jul', value: 3050),
          ChartPoint(name: 'Aug', value: 3100),
          ChartPoint(name: 'Sep', value: 3070),
          ChartPoint(name: 'Oct', value: 3120),
          ChartPoint(name: 'Nov', value: 3080),
          ChartPoint(name: 'Dec', value: 3130),
        ],
        color: context.colors.primary,
        isCurved: true,
      ),
    ];
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total Orders',
              style: context.textTheme.labelLarge?.variant(context),
            ),
            SizedBox(height: 4),
            Row(
              spacing: 8,
              children: <Widget>[
                Text('1.250', style: context.textTheme.headlineSmall),
                AppBadge(
                  suffixIcon: BetterIcons.arrowUp02Outline,
                  text: '+2.9%',
                  size: BadgeSize.small,
                  isRounded: true,
                  color: SemanticColor.success,
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 52,
              child: AppLinearSparkline(
                data: data,
                hasLine: true,
                hasArea: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
