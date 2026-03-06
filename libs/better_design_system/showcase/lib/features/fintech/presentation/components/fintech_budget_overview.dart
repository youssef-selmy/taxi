import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FintechBudgetOverview extends StatelessWidget {
  final SemanticColor incomeColor;
  final SemanticColor expensesColor;
  final SemanticColor scheduledColor;
  const FintechBudgetOverview({
    super.key,
    this.incomeColor = SemanticColor.success,
    this.expensesColor = SemanticColor.error,
    this.scheduledColor = SemanticColor.primary,
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

    final income = [
      40000.0,
      50000.0,
      45000.0,
      33000.0,
      25000.0,
      50000.0,
      40000.0,
      32000.0,
      23000.0,
      45000.0,
      58000.0,
      55000.0,
    ];

    final scheduled = [
      25000.0,
      22000.0,
      20000.0,
      23000.0,
      21000.0,
      20000.0,
      24000.0,
      22000.0,
      20000.0,
      23000.0,
      25000.0,
      24000.0,
    ];

    final expenses = [
      14000.0,
      12000.0,
      10000.0,
      11000.0,
      13000.0,
      9000.0,
      11000.0,
      10000.0,
      10500.0,
      13000.0,
      10000.0,
      10000.0,
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(width: 1, color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Budget Overview', style: context.textTheme.titleSmall),
              const Spacer(),
              SizedBox(
                width: 80,
                child: AppDropdownField.single(
                  type: DropdownFieldType.compact,
                  items: [
                    AppDropdownItem(value: '2025', title: '2025'),
                    AppDropdownItem(value: '2024', title: '2024'),
                    AppDropdownItem(value: '2023', title: '2023'),
                  ],
                  initialValue: '2025',
                ),
              ),
            ],
          ),
          AppDivider(height: 32),
          Row(
            spacing: 32,
            children: [
              // income
              Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 6,
                    children: [
                      BetterDotBadge(
                        color: incomeColor,
                        dotBadgeSize: DotBadgeSize.large,
                      ),
                      Text(
                        "Income",
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        '\$100,000,000',
                        style: context.textTheme.titleSmall,
                      ),
                      AppBadge(
                        prefixIcon: BetterIcons.arrowUpRight01Outline,
                        text: '+8%',
                        size: BadgeSize.small,
                        isRounded: true,
                        color: SemanticColor.success,
                      ),
                    ],
                  ),
                ],
              ),

              // Expenses
              Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 6,
                    children: [
                      BetterDotBadge(
                        color: expensesColor,
                        dotBadgeSize: DotBadgeSize.large,
                      ),
                      Text(
                        'Expenses',
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 8,
                    children: [
                      Text('\$58,900,000', style: context.textTheme.titleSmall),
                      AppBadge(
                        prefixIcon: BetterIcons.arrowDownRight01Outline,
                        text: '-5%',
                        size: BadgeSize.small,
                        isRounded: true,
                        color: SemanticColor.error,
                      ),
                    ],
                  ),
                ],
              ),
              // Scheduled
              Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 6,
                    children: [
                      BetterDotBadge(
                        color: scheduledColor,
                        dotBadgeSize: DotBadgeSize.large,
                      ),
                      Text(
                        'Scheduled',
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),

                  Text('\$9,500,000', style: context.textTheme.titleSmall),
                ],
              ),
            ],
          ),

          SizedBox(height: 16),
          SizedBox(
            height: 240,
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
                          index >= 0 && index < months.length
                              ? months[index]
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
                barGroups: List.generate(months.length, (i) {
                  final incomeValue = income[i];
                  final expensesValue = expenses[i];
                  final scheduledValue = scheduled[i];

                  final stackItems = [
                    BarChartRodStackItem(
                      0,
                      incomeValue,
                      incomeColor.main(context),
                    ),
                    BarChartRodStackItem(
                      incomeValue,
                      incomeValue + scheduledValue,
                      scheduledColor.main(context),
                    ),
                    BarChartRodStackItem(
                      incomeValue + scheduledValue,
                      incomeValue + scheduledValue + expensesValue,
                      expensesColor.main(context),
                    ),
                  ];

                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: incomeValue + scheduledValue + expensesValue,
                        rodStackItems: stackItems,
                        width: 9,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ],
                  );
                }),

                maxY: 100000,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
