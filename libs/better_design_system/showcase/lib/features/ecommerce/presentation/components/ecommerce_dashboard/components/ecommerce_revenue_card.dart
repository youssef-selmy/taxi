import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

enum TimePeriod { daily, weekly, monthly, yearly }

/// Revenue card showing a bar chart for different time periods.
class EcommerceRevenueCard extends StatefulWidget {
  const EcommerceRevenueCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  State<EcommerceRevenueCard> createState() => _EcommerceRevenueCardState();
}

class _EcommerceRevenueCardState extends State<EcommerceRevenueCard> {
  TimePeriod _timePeriod = TimePeriod.yearly;

  Map<TimePeriod, List<ChartData>> _getChartData() {
    return {
      TimePeriod.daily: [
        ChartData('Mon', 4200),
        ChartData('Tue', 5100),
        ChartData('Wed', 3800),
        ChartData('Thu', 6200),
        ChartData('Fri', 5800),
        ChartData('Sat', 4500),
        ChartData('Sun', 3200),
      ],
      TimePeriod.weekly: [
        ChartData('W1', 28000),
        ChartData('W2', 32000),
        ChartData('W3', 29500),
        ChartData('W4', 33000),
      ],
      TimePeriod.monthly: [
        ChartData('Jan', 41000),
        ChartData('Feb', 13000),
        ChartData('Mar', 25000),
        ChartData('Apr', 15000),
        ChartData('May', 28000),
        ChartData('Jun', 37000),
        ChartData('Jul', 40000),
        ChartData('Aug', 23000),
        ChartData('Sep', 14000),
        ChartData('Oct', 25000),
        ChartData('Nov', 36000),
        ChartData('Dec', 21000),
      ],
      TimePeriod.yearly: [
        ChartData('2020', 850000),
        ChartData('2021', 1020000),
        ChartData('2022', 1180000),
        ChartData('2023', 1350000),
        ChartData('2024', 1500000),
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final chartData = _getChartData()[_timePeriod]!;

    // Mobile layout
    if (widget.isMobile) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shadows: [BetterShadow.shadow4.toBoxShadow(context)],
          color: context.colors.surface,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colors.outline),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(BetterIcons.money03Outline, size: 24),
                const SizedBox(width: 8),
                Text('Revenue', style: context.textTheme.titleSmall),
                const Spacer(),
                SizedBox(
                  width: 95,
                  child: AppDropdownField.single(
                    items: [
                      AppDropdownItem(value: TimePeriod.daily, title: 'Daily'),
                      AppDropdownItem(
                        value: TimePeriod.weekly,
                        title: 'Weekly',
                      ),
                      AppDropdownItem(
                        value: TimePeriod.monthly,
                        title: 'Monthly',
                      ),
                      AppDropdownItem(
                        value: TimePeriod.yearly,
                        title: 'Yearly',
                      ),
                    ],
                    type: DropdownFieldType.compact,
                    isFilled: false,
                    initialValue: _timePeriod,
                    onChanged:
                        (value) =>
                            setState(() => _timePeriod = value as TimePeriod),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppChartBar(data: chartData, timePeriod: _timePeriod),
          ],
        ),
      );
    }

    // Desktop layout
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shadows: [BetterShadow.shadow16.toBoxShadow(context)],
        color: context.colors.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.colors.outline),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(BetterIcons.money03Outline, size: 24),
              const SizedBox(width: 8),
              Text('Revenue', style: context.textTheme.titleSmall),
              const Spacer(),
              const SizedBox(width: 8),
              AppToggleSwitchButtonGroup<TimePeriod>(
                options: [
                  ToggleSwitchButtonGroupOption<TimePeriod>(
                    value: TimePeriod.daily,
                    label: 'Daily',
                  ),
                  ToggleSwitchButtonGroupOption<TimePeriod>(
                    value: TimePeriod.weekly,
                    label: 'Weekly',
                  ),
                  ToggleSwitchButtonGroupOption<TimePeriod>(
                    value: TimePeriod.monthly,
                    label: 'Monthly',
                  ),
                  ToggleSwitchButtonGroupOption<TimePeriod>(
                    value: TimePeriod.yearly,
                    label: 'Yearly',
                  ),
                ],
                selectedValue: _timePeriod,
                onChanged:
                    (TimePeriod value) => setState(() => _timePeriod = value),
              ),
            ],
          ),
          const SizedBox(height: 26),
          AppChartBar(data: chartData, timePeriod: _timePeriod),
        ],
      ),
    );
  }
}

class ChartData {
  final String label;
  final double value;

  ChartData(this.label, this.value);
}

class AppChartBar extends StatelessWidget {
  final List<ChartData> data;
  final TimePeriod timePeriod;

  const AppChartBar({super.key, required this.data, required this.timePeriod});

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 240,
      child: BarChart(
        _buildBarChartData(context, maxValue),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  BarChartData _buildBarChartData(BuildContext context, double maxValue) {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: maxValue * 1.2,
      minY: 0,
      barTouchData: BarTouchData(enabled: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= 0 && value.toInt() < data.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    data[value.toInt()].label,
                    style: context.textTheme.labelSmall!.copyWith(
                      color: context.colors.onSurfaceVariantLow,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 48,
            interval: _calculateInterval(maxValue, timePeriod),
            getTitlesWidget: (value, meta) {
              return Text(
                '\$${_formatValue(value)}',
                style: context.textTheme.labelSmall!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: _calculateInterval(maxValue, timePeriod),
        getDrawingHorizontalLine:
            (value) => FlLine(
              color: context.colors.outlineVariant.withValues(alpha: 0.4),
              strokeWidth: 1,
            ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: context.colors.outlineVariant, width: 1),
        ),
      ),
      barGroups:
          data.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: item.value,
                  color: context.colors.primary,
                  width: _getBarWidth(data.length),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  double _getBarWidth(int dataLength) => switch (dataLength) {
    <= 5 => 24,
    <= 7 => 20,
    <= 12 => 16,
    _ => 12,
  };

  double _calculateInterval(double maxValue, TimePeriod timePeriod) {
    if (timePeriod == TimePeriod.monthly) return 10000;

    final interval = maxValue / 4;
    return switch (interval) {
      < 1000 => 1000,
      < 10000 => 10000,
      < 50000 => 50000,
      < 100000 => 100000,
      _ => 200000,
    };
  }

  String _formatValue(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toStringAsFixed(0);
  }
}
