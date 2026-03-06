import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class EcommerceOrdersCard extends StatelessWidget {
  const EcommerceOrdersCard({
    super.key,
    required this.userImage,
    required this.userName,
    required this.orderStatusBadgeText,
    required this.orderStatusBadgeColor,
    required this.paymentStatusBadgeText,
    required this.paymentStatusBadgeColor,
  });

  final Widget userImage;
  final String userName;
  final String orderStatusBadgeText;
  final SemanticColor orderStatusBadgeColor;
  final String paymentStatusBadgeText;
  final SemanticColor paymentStatusBadgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#PRD001',
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
              Text(
                '23 May, 2025',
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
            ],
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(width: 40, height: 40, child: userImage),
              ),
              const SizedBox(width: 8),
              Text(userName, style: context.textTheme.labelLarge),
              const Spacer(),
              Text('\$244.00', style: context.textTheme.labelLarge),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order status:',
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              AppBadge(
                text: orderStatusBadgeText,
                size: BadgeSize.large,
                color: orderStatusBadgeColor,
                isRounded: true,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment status:',
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              AppBadge(
                text: paymentStatusBadgeText,
                size: BadgeSize.large,
                color: paymentStatusBadgeColor,
                isRounded: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
