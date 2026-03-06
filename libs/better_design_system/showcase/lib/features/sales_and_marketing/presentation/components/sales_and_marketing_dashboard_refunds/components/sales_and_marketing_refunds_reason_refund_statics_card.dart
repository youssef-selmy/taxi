import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesAndMarketingRefundsReasonRefundStaticsCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingRefundsReasonRefundStaticsCard({
    super.key,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Reason Refund Statics',
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Optimize again to get your best score',
                    style: context.textTheme.labelSmall?.variant(context),
                  ),
                ],
              ),

              SizedBox(
                width: 120,
                child: AppDropdownField.single(
                  items: [
                    AppDropdownItem(value: 'Monthly', title: 'Monthly'),
                    AppDropdownItem(value: 'Yearly', title: 'Yearly'),
                  ],
                  isFilled: false,
                  initialValue: 'Monthly',
                  type: DropdownFieldType.compact,
                  prefixIcon: BetterIcons.calendar03Outline,
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 16 : 40),

          Row(
            mainAxisAlignment:
                isMobile
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (!isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    _buildChartLegend(
                      context,
                      badgeColor: SemanticColor.primary,
                      title: 'Poor Product Quality',
                      count: '40,872',
                      isMobile: isMobile,
                    ),
                    _buildChartLegend(
                      context,
                      badgeColor: SemanticColor.warning,
                      title: 'Ordering Error',
                      count: '10,987',
                      isMobile: isMobile,
                    ),
                    _buildChartLegend(
                      context,
                      badgeColor: SemanticColor.tertiary,
                      title: 'Product Not as Expected',
                      count: '49,333',
                      isMobile: isMobile,
                    ),
                  ],
                ),
              SizedBox(
                width: 210,
                height: 228,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    startDegreeOffset: -90,
                    sections: [
                      PieChartSectionData(
                        value: 35,
                        color: context.colors.primary,
                        title: '35%',
                        radius: 110,
                        titleStyle: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.onPrimary,
                        ),
                      ),
                      PieChartSectionData(
                        value: 35,
                        color: context.colors.tertiary,
                        title: '35%',
                        radius: 110,
                        titleStyle: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.onPrimary,
                        ),
                      ),
                      PieChartSectionData(
                        value: 30,
                        color: context.colors.warning,
                        title: '30%',
                        radius: 110,
                        titleStyle: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (isMobile) ...[
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                _buildChartLegend(
                  context,
                  badgeColor: SemanticColor.primary,
                  title: 'Poor Product Quality',
                  count: '40,872',
                  isMobile: isMobile,
                ),
                _buildChartLegend(
                  context,
                  badgeColor: SemanticColor.warning,
                  title: 'Ordering Error',
                  count: '10,987',
                  isMobile: isMobile,
                ),
                _buildChartLegend(
                  context,
                  badgeColor: SemanticColor.tertiary,
                  title: 'Product Not as Expected',
                  count: '49,333',
                  isMobile: isMobile,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Column _buildChartLegend(
    BuildContext context, {
    required SemanticColor badgeColor,
    required String title,
    required bool isMobile,
    required String count,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              spacing: 6,
              children: [
                BetterDotBadge(
                  color: badgeColor,
                  dotBadgeSize: DotBadgeSize.large,
                ),
                Text(title, style: context.textTheme.labelMedium),
              ],
            ),
            if (isMobile) Text(count, style: context.textTheme.titleSmall),
          ],
        ),

        if (!isMobile) ...[
          SizedBox(height: 8),
          Text(count, style: context.textTheme.headlineMedium),
        ],
      ],
    );
  }
}
