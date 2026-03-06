import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/widgets.dart';

class SalesAndMarketingSalesCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingSalesCard({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final chartPoints =
        isMobile
            ? <ChartPoint>[
              ChartPoint(name: 'Mon', value: 45),
              ChartPoint(name: 'Tue', value: 48),
              ChartPoint(name: 'Wed', value: 52),
              ChartPoint(name: 'Thu', value: 60),
              ChartPoint(name: 'Fri', value: 68),
              ChartPoint(name: 'Sat', value: 60),
              ChartPoint(name: 'Sun', value: 37),
            ]
            : List.generate(31, (i) {
              final base = 40;
              final trend = i * 1.5;
              final noise = (i % 6 == 0 ? -5 : (i % 3 == 0 ? 3 : 0));
              final value = base + trend + noise;
              return ChartPoint(
                name: '${i + 1}'.padLeft(2, '0'),
                value: value.toDouble(),
              );
            });

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sales', style: context.textTheme.titleSmall),

              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Filled,
                size: ButtonSize.medium,
                style: IconButtonStyle.outline,
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            spacing: 4,
            children: [
              Text('\$56,000,000', style: context.textTheme.headlineSmall),
              AppBadge(
                prefixIcon: BetterIcons.arrowUpRight01Outline,
                text: '+4%',
                size: BadgeSize.small,
                isRounded: true,
                color: SemanticColor.success,
              ),
              Text(
                'From last month',
                style: context.textTheme.labelSmall?.variant(context),
              ),
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: AppLinearSparkline(
              data: [
                ChartSeriesData(
                  points: chartPoints,
                  name: 'Sales',
                  color: context.colors.primary,
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
        ],
      ),
    );
  }
}
