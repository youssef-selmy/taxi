import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class EcommerceProductCard extends StatelessWidget {
  const EcommerceProductCard({
    super.key,
    required this.productId,
    required this.badgeText,
    required this.badgeColor,
    required this.productImage,
    required this.productName,
    required this.price,
    required this.quantity,
  });

  final String productId;
  final String badgeText;
  final SemanticColor badgeColor;
  final Widget productImage;
  final String productName;
  final double price;
  final int quantity;

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
        children: [
          // Header row with product ID, date, and badge
          Row(
            children: [
              Text(
                productId,
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: context.colors.outlineVariant,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Text(
                '23 May, 2025',
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
              const Spacer(),
              AppBadge(
                text: badgeText,
                size: BadgeSize.medium,
                color: badgeColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Product info row with image, name, and price
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(width: 40, height: 40, child: productImage),
              ),
              const SizedBox(width: 8),
              Text(productName, style: context.textTheme.labelLarge),
              const Spacer(),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: context.textTheme.labelLarge,
              ),
              const SizedBox(width: 4),
              Text(
                'USD',
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Quantity row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity:',
                style: context.textTheme.labelLarge!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text('$quantity in stock', style: context.textTheme.labelLarge),
            ],
          ),
        ],
      ),
    );
  }
}
