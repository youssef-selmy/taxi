import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// A reusable metric card used across the ecommerce dashboard.
///
/// Encapsulates the common container decoration and layout used by the
/// small metric cards (icon, sparkline, title, value and badge).
class EcommerceMetricCard extends StatelessWidget {
  const EcommerceMetricCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.badge,
    required this.sparklineData,
    this.useResponsiveShadow = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final Widget badge;
  final List<ChartSeriesData> sparklineData;
  final bool useResponsiveShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              const Spacer(),
              SizedBox(
                height: 30,
                width: 80,
                child: AppLinearSparkline(
                  showTooltip: false,
                  hasArea: true,
                  data: sparklineData,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(value, style: context.textTheme.headlineSmall),
              badge,
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) => BoxDecoration(
    color: context.colors.surface,
    border: Border.all(color: context.colors.outline),
    boxShadow:
        useResponsiveShadow
            ? (context.isDesktop
                ? [BetterShadow.shadow8.toBoxShadow(context)]
                : [BetterShadow.shadow4.toBoxShadow(context)])
            : [BetterShadow.shadow8.toBoxShadow(context)],
    borderRadius: BorderRadius.circular(12),
  );
}
