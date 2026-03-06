import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';

class AppSpendingSummary extends StatelessWidget {
  final bool isFilled;

  const AppSpendingSummary({super.key, this.isFilled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Padding(
          padding: const EdgeInsets.all(13.6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Spending Summary', style: context.textTheme.labelLarge),
                  const Spacer(),
                  SizedBox(
                    width: 150,
                    child: AppDropdownField.single(
                      width: 150,
                      items: [
                        AppDropdownItem(value: 'Last Day', title: 'Last Day'),
                        AppDropdownItem(value: 'Last Week', title: 'Last Week'),
                        AppDropdownItem(
                          value: 'Last Month',
                          title: 'Last Month',
                        ),
                        AppDropdownItem(
                          value: 'Last 3 Months',
                          title: 'Last 3 Months',
                        ),
                      ],
                      type: DropdownFieldType.compact,
                      initialValue: 'Last Week',
                      isFilled: isFilled,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Pie Chart
              SizedBox(
                height: 193.8,
                width: 193.8,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        startDegreeOffset: 90,
                        pieTouchData: PieTouchData(enabled: false),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 1.5,
                        centerSpaceRadius: 90,
                        sections: _buildPieChartSections(context),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Spent',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(height: 2.4),
                        Text('\$2,200.00', style: context.textTheme.labelLarge),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 10.2,
                    height: 10.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 5.1),
                  Text(
                    'Shopping',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text('\$700.00', style: context.textTheme.titleSmall),
                ],
              ),
              const SizedBox(height: 10.2),
              Row(
                children: [
                  Container(
                    width: 10.2,
                    height: 10.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.insight,
                    ),
                  ),
                  const SizedBox(width: 5.1),
                  Text(
                    'Utilities',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text('\$500.00', style: context.textTheme.titleSmall),
                ],
              ),
              const SizedBox(height: 10.2),
              Row(
                children: [
                  Container(
                    width: 10.2,
                    height: 10.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.secondary,
                    ),
                  ),
                  const SizedBox(width: 5.1),
                  Text(
                    'Others',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text('\$600.00', style: context.textTheme.titleSmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(BuildContext context) {
    final shoppingValue = 1.0;
    final utilitiesValue = 0.5;
    final othersValue = 0.5;

    return [
      // Shopping section
      PieChartSectionData(
        color: context.colors.primary,
        value: shoppingValue,
        radius: 8.5,
        showTitle: false,
      ),
      // Utilities section
      PieChartSectionData(
        color: context.colors.insight,
        value: utilitiesValue,
        radius: 8.5,
        showTitle: false,
      ),
      // Others section
      PieChartSectionData(
        color: context.colors.secondary,
        value: othersValue,
        radius: 8.5,
        showTitle: false,
      ),
    ];
  }
}
