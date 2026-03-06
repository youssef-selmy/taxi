import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_card_container.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HrPlatformJobOverviewCard extends StatelessWidget {
  const HrPlatformJobOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HrPlatformCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Job Overview', style: context.textTheme.titleSmall),
          const SizedBox(height: 16),
          // Pie Chart with Legend
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pie Chart
              SizedBox(
                height: 130,
                width: 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        startDegreeOffset: 90,
                        pieTouchData: PieTouchData(enabled: false),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 1.5,
                        centerSpaceRadius: 55,
                        sections: _buildPieChartSections(context),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total',
                          style: context.textTheme.labelMedium!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('712', style: context.textTheme.titleMedium),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Legend
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFB771E5),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Active Job',
                            style: context.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF48CFCB),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'In Reviews Job',
                            style: context.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
                        Flexible(
                          child: Text(
                            'Finish Jobs',
                            style: context.textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(BuildContext context) {
    final shoppingValue = 1.0;
    final utilitiesValue = 0.5;
    final othersValue = 0.5;

    return [
      // Active Job section
      PieChartSectionData(
        color: const Color(0xFFB771E5),
        value: shoppingValue,
        radius: 6.5,
        showTitle: false,
      ),
      // In Reviews Job section
      PieChartSectionData(
        color: const Color(0xFF48CFCB),
        value: utilitiesValue,
        radius: 6.5,
        showTitle: false,
      ),
      // Finish Jobs section
      PieChartSectionData(
        color: const Color(0xFFF4A261),
        value: othersValue,
        radius: 6.5,
        showTitle: false,
      ),
    ];
  }
}
