import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/map_pin/my_location_point.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Customer Growth card showing geographic distribution.
///
/// Displays customer growth by country with flag indicators,
/// percentages, and a world map visualization.
class SalesAndMarketingOverviewCustomerGrowthCard extends StatelessWidget {
  const SalesAndMarketingOverviewCustomerGrowthCard({super.key});

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          // Header section
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Text('Customer Growth', style: context.textTheme.titleSmall),

              // Country indicators
              Row(
                spacing: 8,
                children: [
                  _CountryIndicator(
                    flag: Assets.images.countries.italy,
                    code: 'IT',
                    percentage: '30%',
                  ),
                  _CountryIndicator(
                    flag: Assets.images.countries.ukraine,
                    code: 'UZ',
                    percentage: '30%',
                  ),
                  _CountryIndicator(
                    flag: Assets.images.countries.germany,
                    code: 'GE',
                    percentage: '30%',
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Assets.images.countries.map.image(height: 380, width: 344),
                    // // Location markers
                    Positioned(left: 105, top: 85, child: _LocationMarker()),
                    Positioned(left: 240, top: 135, child: _LocationMarker()),
                    Positioned(left: 155, top: 215, child: _LocationMarker()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountryIndicator extends StatelessWidget {
  final AssetGenImage flag;
  final String code;
  final String percentage;

  const _CountryIndicator({
    required this.flag,
    required this.code,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.colors.outline),
        ),
        child: Row(
          spacing: 8,
          children: [
            flag.image(width: 24, height: 24),
            Expanded(
              child: Text(
                code,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
            Text(percentage, style: context.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _LocationMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppMyLocationPoint();
  }
}
