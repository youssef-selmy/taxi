import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesAndMarketingRegionCard extends StatelessWidget {
  const SalesAndMarketingRegionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
        color: context.colors.surface,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Sales by Region', style: context.textTheme.labelLarge),
              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
              ),
            ],
          ),

          SizedBox(height: 24),

          SizedBox(
            height: 275,
            width: 272,
            child: RadarChart(
              RadarChartData(
                dataSets: [
                  RadarDataSet(
                    dataEntries: [
                      RadarEntry(value: 28.158),
                      RadarEntry(value: 27.752),
                      RadarEntry(value: 28.121),
                      RadarEntry(value: 27.245),
                      RadarEntry(value: 26.239),
                      RadarEntry(value: 26.242),
                    ],
                    fillColor: context.colors.primary.withValues(alpha: 0.4),
                    borderColor: Colors.transparent,
                  ),
                ],
                radarBackgroundColor: Colors.transparent,
                radarBorderData: BorderSide(color: context.colors.outline),
                titlePositionPercentageOffset: 0.1,
                getTitle: (index, angle) {
                  final values = [
                    29.158,
                    28.752,
                    28.121,
                    28.245,
                    28.239,
                    29.239,
                  ];

                  const labels = [
                    'Asia',
                    'Americas',
                    'Africa',
                    'Middle East',
                    'Pacific',
                    'Europe',
                  ];
                  return RadarChartTitle(
                    text: labels[index],
                    children: <InlineSpan>[
                      TextSpan(
                        text: '\n${values[index]}',
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  );
                },
                ticksTextStyle: context.textTheme.labelSmall?.copyWith(
                  color: Colors.transparent,
                ),
                titleTextStyle: context.textTheme.labelMedium?.variant(context),
                tickCount: 3,
                tickBorderData: BorderSide(color: context.colors.outline),
                gridBorderData: BorderSide(color: context.colors.outline),
                radarShape: RadarShape.polygon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
