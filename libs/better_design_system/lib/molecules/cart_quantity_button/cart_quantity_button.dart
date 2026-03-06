import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef BetterCartQuantityButton = AppCartQuantityButton;

class AppCartQuantityButton extends StatelessWidget {
  final double price;
  final bool isUnavailable;
  final int quantity;
  final String currency;
  final SemanticColor color;
  final void Function()? onGoToCartTap;
  final void Function()? onDecreaseTap;
  final void Function()? onIncreaseTap;

  const AppCartQuantityButton({
    super.key,
    required this.price,
    required this.isUnavailable,
    required this.quantity,
    required this.currency,
    required this.onGoToCartTap,
    this.onDecreaseTap,
    this.onIncreaseTap,
    this.color = SemanticColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.surface,
        boxShadow: [kShadow8(context)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            if (!isUnavailable &&
                quantity > 0 &&
                onIncreaseTap != null &&
                onDecreaseTap != null) ...[
              plusMinusButton(context),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: AppFilledButton(
                color: color,
                onPressed: isUnavailable
                    ? null
                    : quantity > 0
                    ? onGoToCartTap
                    : onIncreaseTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        BetterIcons.shoppingBag02Filled,
                        color: color.onColor(context),
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        buttonLabel(context),
                        style: context.textTheme.labelLarge?.copyWith(
                          color: color.onColor(context),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        (price * (quantity == 0 ? 1 : quantity)).formatCurrency(
                          currency,
                        ),
                        style: context.textTheme.titleSmall?.copyWith(
                          color: color.onColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String buttonLabel(BuildContext context) {
    if (isUnavailable) {
      return context.strings.unavailable;
    }
    return switch (quantity) {
      0 => context.strings.addToCart,
      > 0 => context.strings.goToCart,
      _ => throw UnimplementedError(),
    };
  }

  Widget plusMinusButton(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: context.colors.surfaceVariantLow,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AppOutlinedButton(
            onPressed: onDecreaseTap,
            foregroundColor: context.colors.onSurface,
            prefixIcon: BetterIcons.remove01Outline,
          ),
          const SizedBox(width: 12),
          Text(quantity.toString(), style: context.textTheme.labelLarge),
          const SizedBox(width: 12),
          AppFilledButton(
            onPressed: onIncreaseTap,
            prefixIcon: BetterIcons.add01Outline,
            color: SemanticColor.neutral,
          ),
        ],
      ),
    ),
  );
}
