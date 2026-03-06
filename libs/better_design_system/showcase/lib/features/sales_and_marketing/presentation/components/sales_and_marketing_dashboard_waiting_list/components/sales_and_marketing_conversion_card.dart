import 'package:better_design_showcase/core/components/half_donut_chart.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingConversionCard extends StatelessWidget {
  const SalesAndMarketingConversionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
      ),

      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text('Conversion', style: context.textTheme.titleSmall),
                  Row(
                    spacing: 8,
                    children: <Widget>[
                      Text(
                        'From last month',
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      AppBadge(
                        prefixIcon: BetterIcons.arrowUpRight01Outline,
                        text: '-8%',
                        size: BadgeSize.small,
                        isRounded: true,
                        color: SemanticColor.error,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 123,
                child: AppDropdownField.single(
                  items: [
                    AppDropdownItem(value: 'Sep 2025', title: 'Sep 2025'),
                    AppDropdownItem(value: 'Oct2025', title: 'Oct 2025'),
                    AppDropdownItem(value: 'Nov2025', title: 'Nov 2025'),
                  ],
                  isFilled: false,
                  initialValue: 'Sep 2025',
                  type: DropdownFieldType.compact,
                  prefixIcon: BetterIcons.calendar03Outline,
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 62.5),
            child: AppHalfArcChart(mainText: '80.24%', subText: 'Label'),
          ),

          _buildLegend(
            context,
            title: 'Porchased',
            value: '1,899',
            tagColor: SemanticColor.primary,
          ),
          SizedBox(height: 8),
          _buildLegend(
            context,
            title: 'Registered',
            value: '540',
            tagColor: SemanticColor.warning,
          ),
        ],
      ),
    );
  }

  Row _buildLegend(
    BuildContext context, {
    required String title,
    required String value,
    required SemanticColor tagColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          spacing: 4,
          children: <Widget>[
            BetterDotBadge(dotBadgeSize: DotBadgeSize.medium, color: tagColor),
            Text(title, style: context.textTheme.labelLarge),
          ],
        ),
        Text(value, style: context.textTheme.labelLarge?.variant(context)),
      ],
    );
  }
}
