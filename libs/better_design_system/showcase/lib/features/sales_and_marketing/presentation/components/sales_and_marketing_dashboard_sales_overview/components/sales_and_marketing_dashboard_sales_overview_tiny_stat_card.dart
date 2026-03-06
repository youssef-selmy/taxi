import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/widgets.dart';

class SalesAndMarketingDashboardSalesOverviewTinyStatCard
    extends StatelessWidget {
  final String title;
  final String value;
  final double percent;
  const SalesAndMarketingDashboardSalesOverviewTinyStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.percent,
  });

  static const tinyStatCards = [
    SalesAndMarketingDashboardSalesOverviewTinyStatCard(
      title: 'Sales',
      value: '\$56,000,000',
      percent: 3.1,
    ),
    SalesAndMarketingDashboardSalesOverviewTinyStatCard(
      title: 'Orders',
      value: '581',
      percent: 2,
    ),
    SalesAndMarketingDashboardSalesOverviewTinyStatCard(
      title: 'Average Order Value (AOV)',
      value: '\$89.3',
      percent: 2.2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<ChartSeriesData> data = [
      ChartSeriesData(
        name: 'statistics',
        points: [
          ChartPoint(name: 'Jan', value: 3000),
          ChartPoint(name: 'Feb', value: 3100),
          ChartPoint(name: 'Mar', value: 3050),
          ChartPoint(name: 'Apr', value: 3150),
          ChartPoint(name: 'May', value: 3100),
          ChartPoint(name: 'Jun', value: 3200),
        ],
        color: context.colors.success,
        isCurved: true,
      ),
    ];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
        color: context.colors.surface,
      ),
      child: Column(
        spacing: 20,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.textTheme.labelLarge?.variant(context),
              ),
              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Filled,
                size: ButtonSize.medium,
              ),
            ],
          ),

          Row(
            spacing: 12,
            children: <Widget>[
              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value, style: context.textTheme.headlineSmall),

                    Row(
                      spacing: 4,
                      children: [
                        Text(
                          'From last month',
                          style: context.textTheme.labelSmall?.variant(context),
                        ),
                        AppBadge(
                          prefixIcon: BetterIcons.arrowUpRight01Outline,
                          text: percent > 0 ? '+$percent%' : '$percent%',
                          size: BadgeSize.small,
                          isRounded: true,
                          color:
                              percent > 0
                                  ? SemanticColor.success
                                  : SemanticColor.error,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 110,
                height: 56,
                child: AppLinearSparkline(
                  data: data,
                  hasLine: true,
                  hasArea: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
