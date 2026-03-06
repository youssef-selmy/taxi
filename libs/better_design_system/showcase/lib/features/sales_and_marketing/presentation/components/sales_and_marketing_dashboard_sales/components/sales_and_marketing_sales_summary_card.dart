import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingSalesSummaryCard extends StatefulWidget {
  final bool isMobile;
  const SalesAndMarketingSalesSummaryCard({super.key, this.isMobile = false});

  @override
  State<SalesAndMarketingSalesSummaryCard> createState() =>
      _SalesAndMarketingSalesSummaryCardState();
}

class _SalesAndMarketingSalesSummaryCardState
    extends State<SalesAndMarketingSalesSummaryCard> {
  final List<ChartPoint> _weekDataRevenue = [
    ChartPoint(name: 'Mon', value: 40),
    ChartPoint(name: 'Tue', value: 70),
    ChartPoint(name: 'Wed', value: 45),
    ChartPoint(name: 'Thu', value: 45),
    ChartPoint(name: 'Fri', value: 55),
    ChartPoint(name: 'Sat', value: 70),
    ChartPoint(name: 'Sun', value: 45),
  ];

  final List<ChartPoint> _weekDataTarget = [
    ChartPoint(name: 'Mon', value: 25),
    ChartPoint(name: 'Tue', value: 28),
    ChartPoint(name: 'Wed', value: 34),
    ChartPoint(name: 'Thu', value: 40),
    ChartPoint(name: 'Fri', value: 35),
    ChartPoint(name: 'Sat', value: 28),
    ChartPoint(name: 'Sun', value: 25),
  ];

  final List<ChartPoint> _monthDataRevenue = [
    ChartPoint(name: 'Jan', value: 40),
    ChartPoint(name: 'Feb', value: 55),
    ChartPoint(name: 'Mar', value: 60),
    ChartPoint(name: 'Apr', value: 50),
    ChartPoint(name: 'May', value: 65),
    ChartPoint(name: 'Jun', value: 70),
    ChartPoint(name: 'Jul', value: 58),
    ChartPoint(name: 'Aug', value: 62),
    ChartPoint(name: 'Sep', value: 68),
    ChartPoint(name: 'Oct', value: 72),
    ChartPoint(name: 'Nov', value: 75),
    ChartPoint(name: 'Dec', value: 80),
  ];

  final List<ChartPoint> _monthDataTarget = [
    ChartPoint(name: 'Jan', value: 25),
    ChartPoint(name: 'Feb', value: 30),
    ChartPoint(name: 'Mar', value: 35),
    ChartPoint(name: 'Apr', value: 38),
    ChartPoint(name: 'May', value: 40),
    ChartPoint(name: 'Jun', value: 42),
    ChartPoint(name: 'Jul', value: 40),
    ChartPoint(name: 'Aug', value: 44),
    ChartPoint(name: 'Sep', value: 46),
    ChartPoint(name: 'Oct', value: 48),
    ChartPoint(name: 'Nov', value: 50),
    ChartPoint(name: 'Dec', value: 52),
  ];

  List<ChartPoint> getRevenueData() =>
      widget.isMobile ? _weekDataRevenue : _monthDataRevenue;

  List<ChartPoint> getTargetData() =>
      widget.isMobile ? _weekDataTarget : _monthDataTarget;

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
        isCurved: true,
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
              Text('Sales Summary', style: context.textTheme.titleSmall),
              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
                style: IconButtonStyle.outline,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            spacing: 16,
            children: <Widget>[
              _buildChartLegend(
                context,
                title: 'Product 1',
                color: SemanticColor.primary,
              ),
              _buildChartLegend(
                context,
                title: 'Product 2',
                color: SemanticColor.warning,
              ),
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            height: 224,
            child: AppLinearSparkline(
              minY: 0,
              maxY: 100,
              data: chartData,
              hasLine: true,
              hasArea: true,
              gridEnabled: true,
              showTooltip: true,
              bottomTitleBuilder: (label) => label,
              leftTitleBuilder: (value) => '\$${value.toInt()}',
              bottomTitleInterval: 1,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
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
