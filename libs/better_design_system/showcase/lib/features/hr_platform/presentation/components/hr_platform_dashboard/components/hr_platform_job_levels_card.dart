import 'package:better_design_system/molecules/charts/bar_sparkline/bar_sparkline.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_card_container.dart';
import 'package:flutter/material.dart';

class HrPlatformJobLevelsCard extends StatelessWidget {
  const HrPlatformJobLevelsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HrPlatformCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Job Levels', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('3,154', style: context.textTheme.headlineMedium),
              const SizedBox(width: 8),
              Text(
                'Total employees',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: AppBarSparkline(
              axis: Axis.vertical,
              type: BarChartThinColoredType.stacked,
              barWidth: 2,
              data: [
                // First 26 bars - Orange
                ...List.generate(
                  26,
                  (i) => ChartSeriesData(
                    name: 'Bar${i + 1}',
                    points: [ChartPoint(name: 'Bar${i + 1}', value: 1)],
                    color: const Color(0xFFF4A261),
                  ),
                ),
                // Next 26 bars - Purple
                ...List.generate(
                  26,
                  (i) => ChartSeriesData(
                    name: 'Bar${i + 27}',
                    points: [ChartPoint(name: 'Bar${i + 27}', value: 1)],
                    color: const Color(0xFFB771E5),
                  ),
                ),
                // Last 26 bars - Cyan
                ...List.generate(
                  26,
                  (i) => ChartSeriesData(
                    name: 'Bar${i + 53}',
                    points: [ChartPoint(name: 'Bar${i + 53}', value: 1)],
                    color: const Color(0xFF48CFCB),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF4A261),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Freelance',
                style: context.textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 16),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFB771E5),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Full Time',
                style: context.textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 16),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF48CFCB),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Internship',
                style: context.textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
