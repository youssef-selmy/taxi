import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FintechMySubscriptionsCard extends StatelessWidget {
  const FintechMySubscriptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'My Subscriptions',
              style: context.textTheme.titleSmall,
            ),
          ),

          AppDivider(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _mySubscriptionsItem(
                  context,
                  icon: Assets.images.brands.youtube.image(
                    width: 24,
                    height: 24,
                  ),
                  title: 'Youtube',
                  subtitle: '\$55.00',
                  badgeText: 'Paid',
                  tagColor: SemanticColor.success,
                ),
                AppDivider(height: 24),
                _mySubscriptionsItem(
                  context,
                  icon: Assets.images.brands.telegram.image(
                    width: 24,
                    height: 24,
                  ),
                  title: 'Telegram',
                  subtitle: '\$80.00',
                  badgeText: 'Expiring',
                  tagColor: SemanticColor.neutral,
                ),
                AppDivider(height: 24),
                _mySubscriptionsItem(
                  context,
                  icon: Assets.images.brands.facebook.image(
                    width: 24,
                    height: 24,
                  ),
                  title: 'Facebook',
                  subtitle: '\$45.00',
                  badgeText: 'Paused',
                  tagColor: SemanticColor.warning,
                ),
                AppDivider(height: 24),
                _mySubscriptionsItem(
                  context,
                  icon: Assets.images.brands.whatsapp.image(
                    width: 24,
                    height: 24,
                  ),
                  title: 'Whatsapp',
                  subtitle: '\$24.00',
                  badgeText: 'Paid',
                  tagColor: SemanticColor.success,
                ),
              ],
            ),
          ),
          AppDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'View All',
                    color: SemanticColor.neutral,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mySubscriptionsItem(
    BuildContext context, {
    required Widget icon,
    required String title,
    required String subtitle,
    required String badgeText,
    required SemanticColor tagColor,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        spacing: 12,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(8),
            ),

            child: icon,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: <Widget>[
              Text(title, style: context.textTheme.labelMedium),
              Row(
                spacing: 4,
                children: [
                  Text(subtitle, style: context.textTheme.labelLarge),

                  AppBadge(
                    text: 'Month',
                    color: SemanticColor.neutral,
                    size: BadgeSize.medium,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      Row(
        spacing: 12,
        children: [
          AppBadge(
            text: badgeText,
            color: tagColor,
            hasDot: true,
            size: BadgeSize.large,
          ),

          Icon(
            BetterIcons.moreVerticalCircle01Outline,
            size: 20,
            color: context.colors.onSurfaceVariant,
          ),
        ],
      ),
    ],
  );
}
