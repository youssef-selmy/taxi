import 'package:better_design_showcase/core/components/half_donut_chart.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingRegisteredUsersCard extends StatelessWidget {
  const SalesAndMarketingRegisteredUsersCard({super.key});

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
              Text('Registered Users', style: context.textTheme.labelLarge),
              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 72),
            child: AppHalfArcChart(mainText: '5.125', subText: 'Total Users'),
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
                  Text('Premium Plan', style: context.textTheme.labelMedium),
                ],
              ),
              Text('4.125', style: context.textTheme.labelMedium),
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
                  Text('Basic Plan', style: context.textTheme.labelMedium),
                ],
              ),
              Text('1000', style: context.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
