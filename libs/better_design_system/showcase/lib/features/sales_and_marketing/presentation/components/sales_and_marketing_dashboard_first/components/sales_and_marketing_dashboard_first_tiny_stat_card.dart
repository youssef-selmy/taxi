import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingDashboardFirstTinyStatCard extends StatelessWidget {
  final String title;
  final String value;
  final double percent;
  const SalesAndMarketingDashboardFirstTinyStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.percent,
  });

  static const tinyStatCards = [
    SalesAndMarketingDashboardFirstTinyStatCard(
      title: 'Total Income',
      value: '\$40,000.21',
      percent: 20,
    ),
    SalesAndMarketingDashboardFirstTinyStatCard(
      title: 'Profit',
      value: '\$13,000.29',
      percent: 20,
    ),
    SalesAndMarketingDashboardFirstTinyStatCard(
      title: 'Conversion Rate',
      value: '6.98%',
      percent: 20,
    ),
    SalesAndMarketingDashboardFirstTinyStatCard(
      title: 'Total Views',
      value: '4.225.357',
      percent: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: context.textTheme.labelLarge?.variant(context)),
          SizedBox(height: 12),
          Row(
            spacing: 4,
            children: <Widget>[
              Text(value, style: context.textTheme.headlineSmall),
              AppBadge(
                prefixIcon:
                    percent > 0
                        ? BetterIcons.arrowUpRight01Outline
                        : BetterIcons.arrowDownRight01Outline,
                text: percent > 0 ? '+$percent%' : '$percent%',
                size: BadgeSize.small,
                isRounded: true,
                color:
                    percent > 0 ? SemanticColor.success : SemanticColor.error,
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'From last month',
            style: context.textTheme.labelSmall?.variant(context),
          ),
        ],
      ),
    );
  }
}
