import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingSalesAllTimespendingCard extends StatefulWidget {
  final bool isMobile;
  const SalesAndMarketingSalesAllTimespendingCard({
    super.key,
    this.isMobile = false,
  });

  @override
  State<SalesAndMarketingSalesAllTimespendingCard> createState() =>
      _SalesAndMarketingSalesAllTimespendingCardState();
}

class _SalesAndMarketingSalesAllTimespendingCardState
    extends State<SalesAndMarketingSalesAllTimespendingCard> {
  final List<ChartPoint> _weekDataRevenue = [
    ChartPoint(name: 'Mon', value: 26),
    ChartPoint(name: 'Tue', value: 50),
    ChartPoint(name: 'Wed', value: 25),
    ChartPoint(name: 'Thu', value: 55),
    ChartPoint(name: 'Fri', value: 25),
    ChartPoint(name: 'Sat', value: 70),
    ChartPoint(name: 'Sun', value: 35),
  ];

  final List<ChartPoint> _weekDataTarget = [
    ChartPoint(name: 'Mon', value: 25),
    ChartPoint(name: 'Tue', value: 43),
    ChartPoint(name: 'Wed', value: 50),
    ChartPoint(name: 'Thu', value: 30),
    ChartPoint(name: 'Fri', value: 40),
    ChartPoint(name: 'Sat', value: 60),
    ChartPoint(name: 'Sun', value: 45),
  ];

  List<ChartPoint> getRevenueData() => _weekDataRevenue;
  List<ChartPoint> getTargetData() => _weekDataTarget;

  @override
  Widget build(BuildContext context) {
    final chartData = [
      ChartSeriesData(
        points: getRevenueData(),
        name: 'Product 1',
        color: context.colors.primary,
      ),
      ChartSeriesData(
        points: getTargetData(),
        name: 'Product 2',
        color: context.colors.warning,
      ),
    ];

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('All Time Spending', style: context.textTheme.titleSmall),
              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
                style:
                    widget.isMobile
                        ? IconButtonStyle.ghost
                        : IconButtonStyle.outline,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            spacing: 16,
            children: <Widget>[
              _buildChartLegend(
                context,
                title: '\$298K Total Spend',
                color: SemanticColor.primary,
              ),
              _buildChartLegend(
                context,
                title: '\$298K Sales',
                color: SemanticColor.warning,
              ),
            ],
          ),

          AppDivider(height: 36),
          Row(
            spacing: 24,
            children: <Widget>[
              _buildStatItem('66,212', 'User', widget.isMobile),
              _buildStatItem('4,442', 'Orders', widget.isMobile),
              _buildStatItem('41,587', 'Conversion Rate', widget.isMobile),
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 128,
            child: AppLinearSparkline(
              data: chartData,
              hasLine: true,
              hasArea: false,
              gridEnabled: false,
              showTooltip: true,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: <Widget>[
        Text(
          value,
          style:
              isMobile
                  ? context.textTheme.titleMedium
                  : context.textTheme.headlineLarge,
        ),
        Text(label, style: context.textTheme.labelMedium?.variant(context)),
      ],
    );
  }

  Widget _buildChartLegend(
    BuildContext context, {
    required String title,
    required SemanticColor color,
  }) {
    return Row(
      children: [
        BetterDotBadge(dotBadgeSize: DotBadgeSize.large, color: color),
        const SizedBox(width: 6),
        Text(title, style: context.textTheme.labelMedium?.variant(context)),
      ],
    );
  }
}
