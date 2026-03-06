import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingAverageOrderCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingAverageOrderCard({super.key, this.isMobile = false});

  List<ChartPoint> _getChartPoints(
    BuildContext context,
    bool isMobile,
    bool isCurrentMonth,
  ) {
    final values =
        isCurrentMonth
            ? [110, 140, 165, 150, 115, 110, 110, 110, 150, 160, 100, 60]
            : [60, 65, 75, 85, 90, 90, 90, 90, 85, 75, 60, 40];

    if (isMobile) {
      const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return List.generate(
        weekDays.length,
        (i) => ChartPoint(
          name: weekDays[i],
          value: values[i % values.length].toDouble(),
        ),
      );
    }

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return List.generate(
      months.length,
      (i) => ChartPoint(name: months[i], value: values[i].toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
        boxShadow: [BetterShadow.shadow16.toBoxShadow(context)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Average Order Value (AOV)',
                style: context.textTheme.labelLarge,
              ),

              Row(
                spacing: 8,
                children: [
                  isMobile
                      ? AppIconButton(
                        icon: BetterIcons.calendar03Outline,
                        size: ButtonSize.medium,
                        style: IconButtonStyle.outline,
                      )
                      : SizedBox(
                        width: 165,
                        child: AppDropdownField.single(
                          items: [
                            AppDropdownItem(
                              value: 'September 2025',
                              title: 'September 2025',
                            ),
                            AppDropdownItem(
                              value: 'October 2025',
                              title: 'October 2025',
                            ),
                            AppDropdownItem(
                              value: 'November 2025',
                              title: 'November 2025',
                            ),
                          ],
                          isFilled: false,
                          initialValue: 'September 2025',
                          type: DropdownFieldType.compact,
                          prefixIcon: BetterIcons.calendar03Outline,
                        ),
                      ),
                  AppIconButton(
                    icon: BetterIcons.moreVerticalCircle01Outline,
                    size: ButtonSize.medium,
                    style: IconButtonStyle.outline,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                spacing: 4,
                children: [
                  Text('\$89.3', style: context.textTheme.headlineSmall),
                  AppBadge(
                    prefixIcon: BetterIcons.arrowUpRight01Outline,
                    text: '+2.2%',
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
              if (!isMobile) _buildChartLegend(context),
            ],
          ),

          if (isMobile) ...[SizedBox(height: 8), _buildChartLegend(context)],

          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: AppLinearSparkline(
              minY: 0,
              maxY: 250,
              data: [
                ChartSeriesData(
                  points: _getChartPoints(context, isMobile, true),
                  name: 'This month',
                  color: context.colors.primary,
                  isCurved: true,
                ),
                ChartSeriesData(
                  points: _getChartPoints(context, isMobile, false),
                  name: 'Last month',
                  color: context.colors.error,
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

  Widget _buildChartLegend(BuildContext context) {
    return Row(
      spacing: 16,
      children: <Widget>[
        Row(
          children: [
            BetterDotBadge(
              dotBadgeSize: DotBadgeSize.large,
              color: SemanticColor.primary,
            ),
            SizedBox(width: 6),
            Text(
              'This month',
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
        Row(
          children: [
            BetterDotBadge(
              dotBadgeSize: DotBadgeSize.large,
              color: SemanticColor.error,
            ),
            SizedBox(width: 6),
            Text(
              'Last month',
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
      ],
    );
  }
}
