import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AppNewCustomers extends StatelessWidget {
  const AppNewCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16.0)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(BetterIcons.userAdd01Outline, size: 20),
                  const SizedBox(width: 10),
                  Text('New Customers', style: context.textTheme.titleSmall),
                  const SizedBox(width: 10),
                  const Spacer(),
                  SizedBox(
                    width: 95,
                    child: AppDropdownField.single(
                      type: DropdownFieldType.compact,
                      items: [
                        AppDropdownItem(value: 'Weekly', title: 'Weekly'),
                      ],
                      initialValue: 'Weekly',
                      isFilled: false,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    Text('398', style: context.textTheme.headlineSmall),
                    const SizedBox(width: 8),
                    const Spacer(),
                    AppBadge(
                      prefixIcon: BetterIcons.arrowUpRight01Outline,
                      text: '+10%',
                      size: BadgeSize.small,
                      isRounded: true,
                      color: SemanticColor.success,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'last week',
                      style: context.textTheme.labelSmall?.variant(context),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 275,
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(enabled: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 100,
                      checkToShowHorizontalLine: (value) {
                        return value % 100 == 0;
                      },

                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: context.colors.outlineVariant,
                          strokeWidth: 1,
                          dashArray: [5, 4],
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitleAlignment: SideTitleAlignment.outside,
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          interval: 1,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            String text = '';
                            switch (value.toDouble()) {
                              case 0:
                                text = 'Mon';
                                break;
                              case 1:
                                text = 'Tue';
                                break;
                              case 2:
                                text = 'Wed';
                                break;
                              case 3:
                                text = 'Thu';
                                break;
                              case 4:
                                text = 'Fri';
                                break;
                              case 5:
                                text = 'Sat';
                                break;
                              case 6:
                                text = 'Sun';
                                break;
                            }
                            return Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  text,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: context.colors.onSurfaceVariantLow,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 100,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Container(
                              padding: const EdgeInsets.only(bottom: 5),
                              margin: const EdgeInsets.only(right: 18),
                              child: Text(
                                value.toInt().toString(),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colors.onSurfaceVariantLow,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            );
                          },
                          reservedSize: 52,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: -0.1,
                    maxX: 6.5,
                    minY: -0.01,
                    maxY: 500.01,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 110), // Mon
                          FlSpot(1, 265), // Tue
                          FlSpot(2, 140), // Wed
                          FlSpot(3, 280), // Thu
                          FlSpot(4, 190), // Fri
                          FlSpot(5, 285), // Sat
                          FlSpot(6, 390), // Sun
                        ],
                        isCurved: true,
                        curveSmoothness: 0.1,
                        color: context.colors.primary,
                        barWidth: 2.5,
                        isStrokeCapRound: true,
                        isStrokeJoinRound: true,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter:
                              (spot, percent, barData, index) =>
                                  index == barData.spots.length - 1
                                      ? FlDotCirclePainter(
                                        radius: 6,
                                        color: context.colors.primary,
                                      )
                                      : FlDotCirclePainter(
                                        radius: 0,
                                        color: Colors.transparent,
                                        strokeWidth: 0,
                                        strokeColor: Colors.transparent,
                                      ),
                        ),
                        belowBarData: BarAreaData(show: false),
                      ),
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 110), // Mon
                          FlSpot(1, 220), // Tue
                          FlSpot(2, 180), // Wed
                          FlSpot(3, 300), // Thu
                          FlSpot(4, 150), // Fri
                          FlSpot(5, 350), // Sat
                          FlSpot(6, 270), // Sun
                        ],
                        isCurved: true,
                        curveSmoothness: 0.1,
                        color: context.colors.primaryDisabled,
                        barWidth: 2.5,
                        isStrokeCapRound: true,
                        isStrokeJoinRound: true,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
