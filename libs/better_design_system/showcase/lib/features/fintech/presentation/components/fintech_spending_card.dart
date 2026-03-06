import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FintechSpendingCard extends StatefulWidget {
  const FintechSpendingCard({super.key});

  @override
  State<FintechSpendingCard> createState() => _FintechSpendingCardState();
}

class _FintechSpendingCardState extends State<FintechSpendingCard> {
  List chartRange = ['1D', '7D', '1M', '1Y'];

  late String selectedRange;

  @override
  void initState() {
    selectedRange = chartRange.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
        boxShadow: [BetterShadow.shadow16.toBoxShadow(context)],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  Icon(
                    BetterIcons.analytics01Outline,
                    size: 24,
                    color: context.colors.onSurfaceVariant,
                  ),
                  Text('Spending', style: context.textTheme.titleSmall),
                ],
              ),

              AppToggleSwitchButtonGroup<String>(
                selectedValue: selectedRange,
                options:
                    chartRange
                        .map(
                          (e) => ToggleSwitchButtonGroupOption<String>(
                            value: e,
                            label: e,
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRange = value;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: AppLinearSparkline(
              data: [
                ChartSeriesData(
                  points: [
                    ChartPoint(name: 'Jan', value: 450),
                    ChartPoint(name: 'Feb', value: 460),
                    ChartPoint(name: 'Mar', value: 460),
                    ChartPoint(name: 'Apr', value: 465),
                    ChartPoint(name: 'May', value: 460),
                    ChartPoint(name: 'Jun', value: 450),
                  ],
                  name: 'Time Worked',
                  color: context.colors.primary,
                  isCurved: true,
                ),
              ],
              hasLine: true,
              hasArea: true,
              gridEnabled: true,
              showTooltip: true,
              bottomTitleBuilder: (label) => label,
              leftTitleBuilder: (value) => '${value.toInt()}',
              // bottomTitleInterval: 1,
            ),
          ),
        ],
      ),
    );
  }
}
