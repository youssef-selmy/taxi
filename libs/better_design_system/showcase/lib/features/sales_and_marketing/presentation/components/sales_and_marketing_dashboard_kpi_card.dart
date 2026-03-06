import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

/// A KPI card component for the Sales & Marketing dashboard.
///
/// Displays a key performance indicator with title, value, percentage change,
/// and a subtitle. Follows the design system patterns established in other
/// dashboard components.
class SalesAndMarketingDashboardKpiCard extends StatelessWidget {
  /// The title of the KPI (e.g., "Total Revenue").
  final String title;

  /// The main value to display (e.g., "$812,568").
  final String value;

  /// The percentage change indicator (e.g., 8.1).
  final double percent;

  /// The subtitle text shown below the value (e.g., "From last month").
  final String subtitle;

  /// Creates a [SalesAndMarketingDashboardKpiCard].
  const SalesAndMarketingDashboardKpiCard({
    super.key,
    required this.title,
    required this.value,
    required this.percent,
    required this.subtitle,
  });

  /// Static list of KPI cards for the sales dashboard based on Figma design.
  static const kpiCards = [
    SalesAndMarketingDashboardKpiCard(
      title: 'Total Revenue',
      value: '\$812,568',
      percent: 8.1,
      subtitle: 'From last month',
    ),
    SalesAndMarketingDashboardKpiCard(
      title: 'Total Customer',
      value: '779,891',
      percent: 3.2,
      subtitle: 'From last month',
    ),
    SalesAndMarketingDashboardKpiCard(
      title: 'Total Transaction',
      value: '934',
      percent: -4.4,
      subtitle: 'From last month',
    ),
    SalesAndMarketingDashboardKpiCard(
      title: 'Total Product',
      value: '759',
      percent: 2.8,
      subtitle: 'From last month',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with title and icon button
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: context.textTheme.labelLarge),
                AppIconButton(
                  icon: BetterIcons.moreVerticalCircle01Outline,
                  size: ButtonSize.medium,
                ),
              ],
            ),
          ),
          AppDivider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Text(value, style: context.textTheme.headlineSmall),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        AppBadge(
                          prefixIcon:
                              percent > 0
                                  ? BetterIcons.arrowUp02Outline
                                  : BetterIcons.arrowDown02Outline,
                          text: percent > 0 ? '+$percent%' : '$percent%',
                          size: BadgeSize.small,
                          isRounded: true,
                          color:
                              percent > 0
                                  ? SemanticColor.success
                                  : SemanticColor.error,
                        ),
                        Text(
                          subtitle,
                          style: context.textTheme.labelSmall?.variant(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
