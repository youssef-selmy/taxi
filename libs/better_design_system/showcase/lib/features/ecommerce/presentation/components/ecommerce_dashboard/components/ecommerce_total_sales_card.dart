import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'ecommerce_metric_card.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceTotalSalesCard extends StatelessWidget {
  const EcommerceTotalSalesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return EcommerceMetricCard(
      icon: BetterIcons.moneyBag02Outline,
      title: 'Total Sales',
      value: '\$52,000',
      badge: AppBadge(
        text: '12%',
        color: SemanticColor.success,
        prefixIcon: BetterIcons.arrowUp02Outline,
        size: BadgeSize.small,
        isRounded: true,
      ),
      sparklineData: [
        ChartSeriesData(
          name: 'Sales',
          points: [
            ChartPoint(name: '1', value: 0.2),
            ChartPoint(name: '2', value: 0.5),
            ChartPoint(name: '3', value: 0.3),
            ChartPoint(name: '4', value: 0.4),
            ChartPoint(name: '5', value: 0.35),
            ChartPoint(name: '6', value: 0.8),
            ChartPoint(name: '7', value: 0.6),
            ChartPoint(name: '8', value: 0.7),
            ChartPoint(name: '9', value: 0.65),
            ChartPoint(name: '10', value: 0.9),
          ],
          color: context.colors.success,
          isCurved: true,
        ),
      ],
    );
  }
}
