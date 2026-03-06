import 'package:better_design_system/atoms/percent_badge/percent_badge.dart';
import 'package:better_design_system/molecules/charts/bar_sparkline/bar_sparkline.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/widgets.dart';

typedef BetterBarChartStatCard = AppBarChartStatCard;

class AppBarChartStatCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? totalNumber;
  final double? percent;
  final Widget? leading;
  final List<Widget>? actions;
  final List<ChartSeriesData> chartSeriesData;
  final double width;
  final double chartHeight;

  const AppBarChartStatCard({
    super.key,
    required this.chartSeriesData,
    this.title,
    this.subtitle,
    this.totalNumber,
    this.percent,
    this.leading,
    this.actions,
    this.width = 800,
    this.chartHeight = 240,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            blurRadius: 16,
            color: context.colors.shadow,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title ?? '', style: context.textTheme.titleSmall),
              if (actions != null) Row(spacing: 8, children: [...actions!]),
            ],
          ),
          const SizedBox(height: 16),
          if (leading != null ||
              totalNumber != null ||
              percent != null ||
              subtitle != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (leading != null) leading!,
                if (totalNumber != null || percent != null || subtitle != null)
                  Row(
                    spacing: 4,
                    children: [
                      if (totalNumber != null)
                        Text(
                          totalNumber!,
                          style: context.textTheme.headlineSmall,
                        ),
                      if (percent != null) AppPercentBadge(percent: percent!),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: context.textTheme.labelSmall?.variant(context),
                        ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          SizedBox(
            height: chartHeight,
            child: AppBarSparkline(
              leftTitleBuilder: (value) => value.toStringAsFixed(1),
              data: chartSeriesData,
              gridEnabled: true,
              type: BarChartThinColoredType.grouped,
              bottomTitleBuilder: (value) => value.toUpperCase(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: context.colors.outline,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Row(
            children: <Widget>[
              ...chartSeriesData
                  .map(
                    (e) => Row(
                      spacing: 6,
                      children: <Widget>[
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: e.color,
                          ),
                        ),
                        Text(
                          e.name,
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList()
                  .separated(separator: const SizedBox(width: 24)),
            ],
          ),
        ],
      ),
    );
  }
}
