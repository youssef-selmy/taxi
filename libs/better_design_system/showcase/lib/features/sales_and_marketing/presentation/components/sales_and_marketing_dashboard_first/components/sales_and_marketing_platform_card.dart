import 'package:better_design_showcase/core/components/pie_chart.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingPlatformCard extends StatelessWidget {
  const SalesAndMarketingPlatformCard({super.key});

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sales by E-commerce Platform',
                style: context.textTheme.labelLarge,
              ),
              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 34),
            child: AppPieChart(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                spacing: 6,
                children: [
                  BetterDotBadge(
                    color: SemanticColor.primary,
                    dotBadgeSize: DotBadgeSize.large,
                  ),
                  Text(
                    'Amazon',
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
              Text('50%', style: context.textTheme.labelMedium),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                spacing: 6,
                children: [
                  BetterDotBadge(
                    color: SemanticColor.warning,
                    dotBadgeSize: DotBadgeSize.large,
                  ),
                  Text(
                    'Alibaba',
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
              Text('25%', style: context.textTheme.labelMedium),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                spacing: 6,
                children: [
                  BetterDotBadge(
                    color: SemanticColor.tertiary,
                    dotBadgeSize: DotBadgeSize.large,
                  ),
                  Text(
                    'Tokopedia',
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
              Text('15%', style: context.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
