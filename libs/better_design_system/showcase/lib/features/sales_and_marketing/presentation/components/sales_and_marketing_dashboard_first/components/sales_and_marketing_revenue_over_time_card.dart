import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingRevenueOverTimeCard extends StatelessWidget {
  const SalesAndMarketingRevenueOverTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              Text('Revenue Over Time', style: context.textTheme.labelLarge),

              Row(
                children: [
                  AppIconButton(
                    icon: BetterIcons.arrowDown03Outline,
                    size: ButtonSize.medium,
                  ),
                  AppIconButton(
                    icon: BetterIcons.moreVerticalCircle01Outline,
                    size: ButtonSize.medium,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            spacing: 16,
            children: [
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BetterDotBadge(
                        dotBadgeSize: DotBadgeSize.large,
                        color: SemanticColor.primary,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Total Revenue',
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('\$25,500', style: context.textTheme.labelMedium),
                      SizedBox(width: 6),
                      AppBadge(
                        prefixIcon: BetterIcons.arrowUpRight01Outline,
                        text: '+20%',
                        size: BadgeSize.small,
                        isRounded: true,
                        color: SemanticColor.success,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BetterDotBadge(
                        dotBadgeSize: DotBadgeSize.large,
                        color: SemanticColor.warning,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Total Target',
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('\$27,500', style: context.textTheme.labelMedium),
                      SizedBox(width: 6),
                      AppBadge(
                        prefixIcon: BetterIcons.arrowUpRight01Outline,
                        text: '+28%',
                        size: BadgeSize.small,
                        isRounded: true,
                        color: SemanticColor.success,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: AppLinearSparkline(
              minY: 0,
              maxY: 100,
              data: [
                ChartSeriesData(
                  points: [
                    ChartPoint(name: 'Mon', value: 40),
                    ChartPoint(name: 'Tue', value: 70),
                    ChartPoint(name: 'Wed', value: 45),
                    ChartPoint(name: 'Thu', value: 45),
                    ChartPoint(name: 'Fri', value: 55),
                    ChartPoint(name: 'Sat', value: 70),
                    ChartPoint(name: 'Sun', value: 45),
                  ],
                  name: 'Total Revenue',
                  color: context.colors.primary,
                ),
                ChartSeriesData(
                  points: [
                    ChartPoint(name: 'Mon', value: 25),
                    ChartPoint(name: 'Tue', value: 28),
                    ChartPoint(name: 'Wed', value: 34),
                    ChartPoint(name: 'Thu', value: 40),
                    ChartPoint(name: 'Fri', value: 35),
                    ChartPoint(name: 'Sat', value: 28),
                    ChartPoint(name: 'Sun', value: 25),
                  ],
                  name: 'Total Target',
                  color: context.colors.warning,
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
            ),
          ),
        ],
      ),
    );
  }
}
