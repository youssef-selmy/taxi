import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingWaitingListSalesCard extends StatefulWidget {
  final bool isMobile;
  const SalesAndMarketingWaitingListSalesCard({
    super.key,
    this.isMobile = false,
  });

  @override
  State<SalesAndMarketingWaitingListSalesCard> createState() =>
      _SalesAndMarketingWaitingListSalesCardState();
}

class _SalesAndMarketingWaitingListSalesCardState
    extends State<SalesAndMarketingWaitingListSalesCard> {
  late final List<String> labels;
  late final List<int> directSalesValues;
  late final List<int> registrationValues;
  final waitingListRegistration = SemanticColor.primary;
  final directSales = SemanticColor.warning;
  final tabs = ['12 month', '30 days', '7 days', '24 hours'];
  late String selectedTab;
  @override
  void initState() {
    super.initState();
    selectedTab = tabs.first;
    labels =
        widget.isMobile
            ? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
            : [
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

    directSalesValues =
        widget.isMobile
            ? [40, 45, 50, 60, 55, 70, 65]
            : [40, 45, 50, 35, 25, 55, 45, 40, 30, 40, 55, 50];

    registrationValues =
        widget.isMobile
            ? [20, 18, 22, 25, 28, 30, 25]
            : [20, 25, 15, 20, 18, 15, 20, 22, 18, 30, 25, 20];
  }

  void onTabChanged(String value) {
    setState(() {
      selectedTab = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(width: 1, color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sales', style: context.textTheme.titleSmall),
              if (!widget.isMobile)
                AppToggleSwitchButtonGroup<String>(
                  options:
                      tabs
                          .map(
                            (e) => ToggleSwitchButtonGroupOption(
                              value: e,
                              label: e,
                            ),
                          )
                          .toList(),
                  onChanged: onTabChanged,
                  selectedValue: selectedTab,
                ),
              if (widget.isMobile)
                AppIconButton(
                  icon: BetterIcons.calendar03Outline,
                  size: ButtonSize.medium,
                  style: IconButtonStyle.outline,
                ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                spacing: 4,
                children: <Widget>[
                  Text('51,215', style: context.textTheme.headlineSmall),
                  AppBadge(
                    prefixIcon: BetterIcons.arrowUpRight01Outline,
                    text: '+4%',
                    size: BadgeSize.small,
                    isRounded: true,
                    color: SemanticColor.success,
                  ),
                ],
              ),

              if (!widget.isMobile) _buildChartLegend(context),
            ],
          ),

          if (widget.isMobile) ...[
            SizedBox(height: 8),
            _buildChartLegend(context),
          ],

          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final directValue = directSalesValues[groupIndex];
                      final regValue = registrationValues[groupIndex];
                      return BarTooltipItem(
                        '${directValue + regValue}',
                        context.textTheme.labelLarge ?? TextStyle(),
                      );
                    },
                  ),
                ),
                minY: 0,
                maxY: 100,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 15,
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
                      reservedSize: 40,
                      interval: 15,
                      getTitlesWidget: (value, meta) {
                        final label = value.toInt().toString();
                        return Text(label, style: context.textTheme.bodySmall);
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
                          style: context.textTheme.bodySmall,
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barGroups: List.generate(labels.length, (i) {
                  final directSalesValue = directSalesValues[i].toDouble();
                  final registrationValue = registrationValues[i].toDouble();

                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: directSalesValue + registrationValue,
                        rodStackItems: [
                          BarChartRodStackItem(
                            0,
                            directSalesValue,
                            directSales.main(context),
                          ),
                          BarChartRodStackItem(
                            directSalesValue,
                            directSalesValue + registrationValue,
                            waitingListRegistration.main(context),
                          ),
                        ],
                        width: 9,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildChartLegend(BuildContext context) {
    return Row(
      children: <Widget>[
        BetterDotBadge(dotBadgeSize: DotBadgeSize.large, color: directSales),
        SizedBox(width: 6),
        Text(
          'Direct Sales',
          style: context.textTheme.labelMedium?.variant(context),
        ),
        SizedBox(width: 16),
        BetterDotBadge(
          dotBadgeSize: DotBadgeSize.large,
          color: waitingListRegistration,
        ),
        SizedBox(width: 6),
        Text(
          'Waiting List Registration',
          style: context.textTheme.labelMedium?.variant(context),
        ),
      ],
    );
  }
}
