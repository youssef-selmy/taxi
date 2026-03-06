import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FintechTotalBalanceCard extends StatelessWidget {
  const FintechTotalBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartSeriesData> data = [
      ChartSeriesData(
        name: 'Total Balance',
        points: [
          ChartPoint(name: 'Jan', value: 3000),
          ChartPoint(name: 'Feb', value: 3100),
          ChartPoint(name: 'Mar', value: 3050),
          ChartPoint(name: 'Apr', value: 3150),
          ChartPoint(name: 'May', value: 3100),
          ChartPoint(name: 'Jun', value: 3200),
        ],
        color: context.colors.success,
        isCurved: true,
      ),
    ];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total Balance',
                style: context.textTheme.labelLarge?.variant(context),
              ),
              SizedBox(
                width: 90,
                child: AppDropdownField.single(
                  items: [
                    AppDropdownItem(
                      title: 'USD',
                      value: 'USD',
                      prefix: Assets.images.countries.unitedStates.image(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    AppDropdownItem(
                      title: 'EUR',
                      value: 'EUR',
                      prefix: Assets.images.countries.europeanUnionSvg.image(
                        width: 24,
                        height: 24,
                      ),
                    ),
                    AppDropdownItem(
                      title: 'GBP',
                      value: 'GBP',
                      prefix: Assets.images.countries.unitedKingdom.image(
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                  type: DropdownFieldType.inLine,
                  initialValue: 'USD',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            spacing: 8,
            children: <Widget>[
              Text('\$18,710.80', style: context.textTheme.headlineSmall),
              AppBadge(
                prefixIcon: BetterIcons.arrowUpRight01Outline,
                text: '+5.4%',
                size: BadgeSize.small,
                isRounded: true,
                color: SemanticColor.success,
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: AppLinearSparkline(data: data, hasLine: true, hasArea: true),
          ),
        ],
      ),
    );
  }
}
