import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class _ChartLegend {
  final SemanticColor color;
  final String title;
  final String value;
  final double percent;

  const _ChartLegend({
    required this.color,
    required this.title,
    required this.value,
    required this.percent,
  });
}

class ChartCustomerChurnRateCard extends StatelessWidget {
  const ChartCustomerChurnRateCard({super.key});

  List<_ChartLegend> _getLegends(BuildContext context) {
    return [
      _ChartLegend(
        color: SemanticColor.error,
        title: 'High price',
        value: '35%',
        percent: -2.6,
      ),
      _ChartLegend(
        color: SemanticColor.warning,
        title: 'Poor UX',
        value: '17.5%',
        percent: -1.2,
      ),
      _ChartLegend(
        color: SemanticColor.success,
        title: 'No Longer Needed',
        value: '17.5%',
        percent: 0.1,
      ),
      _ChartLegend(
        color: SemanticColor.secondary,
        title: 'Switched to Competitor',
        value: '16%',
        percent: 1.4,
      ),
      _ChartLegend(
        color: SemanticColor.info,
        title: 'Other Reasons',
        value: '14%',
        percent: -0.8,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  spacing: 8,
                  children: [
                    Text(
                      'Customer Churn Rate',
                      style: context.textTheme.titleSmall,
                    ),
                    Text(
                      'What caused users to leave',
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                  ],
                ),

                AppOutlinedButton(
                  onPressed: () {},
                  text: 'Sort by',
                  color: SemanticColor.neutral,
                  prefixIcon: BetterIcons.menu11Outline,
                  size: ButtonSize.medium,
                ),
              ],
            ),
            SizedBox(height: 16),

            Row(
              spacing: 4,
              children: <Widget>[
                Text('4.2%', style: context.textTheme.displayMedium),
                Icon(
                  BetterIcons.arrowDownRight01Outline,
                  color: context.colors.error,
                  size: 20,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: SizedBox(
                height: 228,
                width: 228,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        startDegreeOffset: -90,
                        pieTouchData: PieTouchData(enabled: false),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 1.5,
                        centerSpaceRadius: 105,
                        sections: _buildPieChartSections(context),
                      ),
                    ),
                    Column(
                      spacing: 4,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Label',
                          style: context.textTheme.labelMedium?.variant(
                            context,
                          ),
                        ),
                        Text('80.24%', style: context.textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Column(
              spacing: 16,
              children: [
                ..._getLegends(context).map(
                  (legend) => _buildChartLegend(
                    context,
                    color: legend.color,
                    title: legend.title,
                    value: legend.value,
                    percent: legend.percent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartLegend(
    BuildContext context, {
    required SemanticColor color,
    required String title,
    required String value,
    required double percent,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 8,
          children: <Widget>[
            BetterDotBadge(color: color, dotBadgeSize: DotBadgeSize.small),
            Text(title, style: context.textTheme.bodyMedium?.variant(context)),
          ],
        ),
        Row(
          spacing: 4,
          children: <Widget>[
            Text(value, style: context.textTheme.labelLarge),
            AppBadge(
              text: percent > 0 ? '+$percent%' : '$percent%',
              color: percent > 0 ? SemanticColor.success : SemanticColor.error,
              suffixIcon: BetterIcons.arrowDownRight01Outline,
              isRounded: true,
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections(BuildContext context) {
    final List<double> legendValues = [0.2, 0.2, 0.1, 0.15, 0.15];
    final List<_ChartLegend> legends = _getLegends(context);

    return [
      ...List.generate(legends.length, (index) {
        _ChartLegend legend = legends[index];
        return PieChartSectionData(
          color: legend.color.main(context),
          value: legendValues[index],
          radius: 8.5,
          showTitle: false,
        );
      }),
    ];
  }
}
