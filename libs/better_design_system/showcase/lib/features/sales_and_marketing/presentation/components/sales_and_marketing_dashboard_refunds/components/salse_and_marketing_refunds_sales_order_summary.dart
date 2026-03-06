import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalseAndMarketingRefundsSalesOrderSummary extends StatelessWidget {
  final bool isMobile;
  const SalseAndMarketingRefundsSalesOrderSummary({
    super.key,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final months = [
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

    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final lastYear = [
      34000.0,
      53000.0,
      34000.0,
      11000.0,
      48000.0,
      34000.0,
      11000.0,
      34000.0,
      48000.0,
      34000.0,
      29000.0,
      34000.0,
    ];

    final currenYear = [
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
      27000.0,
    ];

    final labels = isMobile ? weekdays : months;
    final visibleLastYear = isMobile ? lastYear.take(7).toList() : lastYear;
    final visibleCurrentYear =
        isMobile ? currenYear.take(7).toList() : currenYear;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sales Order Summary', style: context.textTheme.titleSmall),
              Row(
                spacing: 8,
                children: [
                  if (!isMobile)
                    SizedBox(
                      width: 116,
                      child: AppDropdownField.single(
                        isFilled: false,
                        type: DropdownFieldType.compact,
                        items: [
                          AppDropdownItem(
                            value: '2024-2025',
                            title: '2024-2025',
                          ),
                          AppDropdownItem(
                            value: '2023-2024',
                            title: '2023-2024',
                          ),
                        ],
                        initialValue: '2024-2025',
                      ),
                    ),
                  if (isMobile)
                    AppIconButton(
                      icon: BetterIcons.calendar03Outline,
                      size: ButtonSize.medium,
                      style: IconButtonStyle.outline,
                      onPressed: () {},
                    ),
                  AppIconButton(
                    icon: BetterIcons.moreVerticalCircle01Outline,
                    size: ButtonSize.medium,
                    style: IconButtonStyle.outline,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 8), _buildChartLegend(context),

          const SizedBox(height: 16),

          // Bar chart
          SizedBox(
            height: 246,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20000,
                  getDrawingHorizontalLine:
                      (value) => FlLine(
                        color: context.colors.outlineVariant,
                        dashArray: [5, 4],
                        strokeWidth: 1,
                      ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      interval: 20000,
                      getTitlesWidget: (value, meta) {
                        final label =
                            value == 0 ? '0' : '${(value / 1000).round()}K';
                        return Text(
                          label,
                          style: context.textTheme.bodySmall?.variant(context),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        return Text(
                          index >= 0 && index < labels.length
                              ? labels[index]
                              : '',
                          style: context.textTheme.bodySmall?.variant(context),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barGroups: List.generate(labels.length, (i) {
                  final lastYearValue = visibleLastYear[i];
                  final currentValue = visibleCurrentYear[i];
                  return BarChartGroupData(
                    x: i,
                    barsSpace: 2,
                    barRods: [
                      BarChartRodData(
                        toY: currentValue,
                        width: 9,
                        borderRadius: BorderRadius.circular(100),
                        color: context.colors.warning,
                      ),
                      BarChartRodData(
                        toY: lastYearValue,
                        width: 9,
                        borderRadius: BorderRadius.circular(100),
                        color: context.colors.primary,
                      ),
                    ],
                  );
                }),

                maxY: 100000,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => context.colors.surfaceContainer,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final label =
                          rodIndex == 0 ? 'Last Year' : 'Current Year';
                      final value = '\$${(rod.toY / 1000).toStringAsFixed(0)}K';
                      return BarTooltipItem(
                        '$label\n$value',
                        context.textTheme.bodySmall!,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Row(
          spacing: 6,
          children: [
            BetterDotBadge(
              dotBadgeSize: DotBadgeSize.large,
              color: SemanticColor.primary,
            ),
            Text(
              'Sales 2024',
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
        Row(
          spacing: 6,
          children: [
            BetterDotBadge(
              dotBadgeSize: DotBadgeSize.large,
              color: SemanticColor.warning,
            ),
            Text(
              'Sales 2025',
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
      ],
    );
  }
}
