import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:fl_chart/fl_chart.dart';

// Make sure the path to arc_painter.dart is correct for your project structure
import 'ecommerce_arc_painter.dart';

class EcommerceUserActivityCard extends StatelessWidget {
  const EcommerceUserActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppClickableCard(
      padding: EdgeInsets.zero,
      type: ClickableCardType.elevated,
      elevation:
          context.isDesktop ? BetterShadow.shadow16 : BetterShadow.shadow4,
      child: Padding(
        padding:
            context.isDesktop
                ? const EdgeInsets.all(20)
                : const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(BetterIcons.userMultipleOutline, size: 24),
                const SizedBox(width: 10),
                Text('User Activity', style: context.textTheme.titleSmall),
                const Spacer(),
                SizedBox(
                  width: 95,
                  child: AppDropdownField.single(
                    items: [
                      AppDropdownItem(value: 'Daily', title: 'Daily'),
                      AppDropdownItem(value: 'Weekly', title: 'Weekly'),
                      AppDropdownItem(value: 'Monthly', title: 'Monthly'),
                    ],
                    type: DropdownFieldType.compact,
                    isFilled: false,
                    initialValue: 'Monthly',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 193.8,
              width: 193.8,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background gray rings
                  PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      pieTouchData: PieTouchData(enabled: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 80, // Outer ring position
                      sections: [
                        PieChartSectionData(
                          color: context.colors.surfaceVariant,
                          value: 100,
                          radius: 10.33, // Thickness
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                  PieChart(
                    PieChartData(
                      startDegreeOffset: -90,
                      pieTouchData: PieTouchData(enabled: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 60, // Inner ring position
                      sections: [
                        PieChartSectionData(
                          color: context.colors.surfaceVariant,
                          value: 100,
                          radius: 10.33, // Thickness
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),

                  // Outer data ring with rounded ends
                  SizedBox(
                    width: 170.66, // (75 + 10.33) * 2
                    height: 170.66,
                    child: CustomPaint(
                      painter: EcommerceArcPainter(
                        progress: 0.5, // 50%
                        color: context.colors.primary,
                        strokeWidth: 10.33,
                      ),
                    ),
                  ),

                  // Inner data ring with rounded ends
                  SizedBox(
                    width: 130.66, // (55 + 10.33) * 2
                    height: 130.66,
                    child: CustomPaint(
                      painter: EcommerceArcPainter(
                        progress: 0.5, // 50%
                        color: context.colors.primaryVariant,
                        strokeWidth: 10.33,
                      ),
                    ),
                  ),

                  // Center content
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total',
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('24,151', style: context.textTheme.titleMedium),
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
                const SizedBox(width: 6),
                Text('Product Viewed', style: context.textTheme.labelMedium),
                const Spacer(),
                Text('50%', style: context.textTheme.labelMedium),
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
                    color: context.colors.primaryVariant,
                  ),
                ),
                const SizedBox(width: 6),
                Text('Checkout', style: context.textTheme.labelMedium),
                const Spacer(),
                Text('50%', style: context.textTheme.labelMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
