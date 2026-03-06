import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class AppPricingPlans extends StatefulWidget {
  final SemanticColor? color;
  const AppPricingPlans({super.key, this.color});

  @override
  State<AppPricingPlans> createState() => _AppPricingPlansState();
}

class _AppPricingPlansState extends State<AppPricingPlans> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16.0)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: SemanticColor.primary.containerColor(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(
                      BetterIcons.rocketFilled,
                      size: 24,
                      color: SemanticColor.primary.main(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text('Pro', style: context.textTheme.titleSmall),
                  const SizedBox(width: 10),
                  AppBadge(
                    text: 'Most Popular',
                    size: BadgeSize.large,
                    color: SemanticColor.primary,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Text('\$1,699', style: context.textTheme.titleLarge),
                  const SizedBox(width: 4),
                  Text(
                    'USD/monthly',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                'Lifetime access to the full source code — no setup included. Own it, customize it, and deploy it your way with a single one-time payment.',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: AppFilledButton(text: 'Choose Basic', onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
