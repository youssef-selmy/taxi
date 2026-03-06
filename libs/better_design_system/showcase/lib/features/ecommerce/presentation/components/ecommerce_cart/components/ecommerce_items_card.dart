import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/counter_input/counter_input.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceItemsCard extends StatelessWidget {
  const EcommerceItemsCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 16.0 : 24.0;
    final shadow =
        isMobile
            ? BetterShadow.shadow4.toBoxShadow(context)
            : BetterShadow.shadow16.toBoxShadow(context);

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [shadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: isMobile ? 16 : 0,
        children: [
          _buildHeader(context),
          if (!isMobile) const SizedBox(height: 32),
          isMobile ? _buildMobileItems(context) : _buildDesktopItems(context),
          if (!isMobile) const SizedBox(height: 32),
          SizedBox(
            width: isMobile ? double.infinity : null,
            child: AppOutlinedButton(
              onPressed: () {},
              text: 'Continue Shopping',
              color: SemanticColor.neutral,
              prefixIcon: BetterIcons.arrowLeft01Outline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Text('Items', style: context.textTheme.titleMedium),
        Text(
          '(2)',
          style: context.textTheme.labelLarge!.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileItems(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        // First item
        Column(
          children: [
            Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Assets.images.products.shoe01EcommerceCart.image(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Men\'s Shoes',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Air Jordan 1 Mid',
                        style: context.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Size:',
                            style: context.textTheme.labelMedium!.copyWith(
                              color: context.colors.onSurfaceVariantLow,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text('43', style: context.textTheme.labelMedium),
                          const SizedBox(width: 8),
                          Text(
                            'Color:',
                            style: context.textTheme.labelMedium!.copyWith(
                              color: context.colors.onSurfaceVariantLow,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text('White', style: context.textTheme.labelMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 114,
                  child: AppCounterInput(
                    initialValue: 1,
                    isFilled: false,
                    min: 1,
                    max: 9,
                  ),
                ),
                const Spacer(),
                Text('\$110.99', style: context.textTheme.titleSmall),
                const SizedBox(width: 8),
                AppTextButton(
                  onPressed: () {},
                  prefixIcon: BetterIcons.delete03Outline,
                  color: SemanticColor.error,
                  size: ButtonSize.medium,
                ),
              ],
            ),
          ],
        ),
        AppDivider(),
        // Second item
        Column(
          children: [
            Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Assets.images.products.shoe02EcommerceCart.image(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Men\'s Shoes',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Air Jordan 1 Low SE',
                        style: context.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Size:',
                            style: context.textTheme.labelMedium!.copyWith(
                              color: context.colors.onSurfaceVariantLow,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text('43', style: context.textTheme.labelMedium),
                          const SizedBox(width: 8),
                          Text(
                            'Color:',
                            style: context.textTheme.labelMedium!.copyWith(
                              color: context.colors.onSurfaceVariantLow,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text('Gray', style: context.textTheme.labelMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 114,
                  child: AppCounterInput(
                    initialValue: 1,
                    isFilled: false,
                    min: 1,
                    max: 9,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$120.99',
                  style: context.textTheme.labelSmall!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: context.colors.onSurfaceVariantLow,
                  ),
                ),
                const SizedBox(width: 4),
                Text('\$110.99', style: context.textTheme.titleSmall),
                const SizedBox(width: 8),
                AppTextButton(
                  onPressed: () {},
                  prefixIcon: BetterIcons.delete03Outline,
                  color: SemanticColor.error,
                  size: ButtonSize.medium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopItems(BuildContext context) {
    return Column(
      children: [
        // First item
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: Assets.images.products.shoe01EcommerceCart.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Men\'s Shoes',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: context.colors.onSurfaceVariantLow,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Air Jordan 1 Mid', style: context.textTheme.labelLarge),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Size:',
                        style: context.textTheme.labelMedium!.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text('43', style: context.textTheme.labelMedium),
                      const SizedBox(width: 8),
                      Text(
                        'Color:',
                        style: context.textTheme.labelMedium!.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text('White', style: context.textTheme.labelMedium),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 112,
              child: AppCounterInput(
                initialValue: 1,
                isFilled: false,
                min: 1,
                max: 9,
              ),
            ),
            const SizedBox(width: 142),
            Text('\$110.99', style: context.textTheme.titleSmall),
            const SizedBox(width: 8),
            AppTextButton(
              onPressed: () {},
              prefixIcon: BetterIcons.delete03Outline,
              color: SemanticColor.error,
              size: ButtonSize.medium,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.5),
          child: AppDivider(),
        ),
        // Second item
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: Assets.images.products.shoe02EcommerceCart.provider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Men\'s Shoes',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: context.colors.onSurfaceVariantLow,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Air Jordan 1 Low SE',
                    style: context.textTheme.labelLarge,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Size:',
                        style: context.textTheme.labelMedium!.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text('43', style: context.textTheme.labelMedium),
                      const SizedBox(width: 8),
                      Text(
                        'Color:',
                        style: context.textTheme.labelMedium!.copyWith(
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text('Gray', style: context.textTheme.labelMedium),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 112,
              child: AppCounterInput(
                initialValue: 1,
                isFilled: false,
                min: 1,
                max: 9,
              ),
            ),
            const SizedBox(width: 99),
            Text(
              '\$120.99',
              style: context.textTheme.labelSmall!.copyWith(
                decoration: TextDecoration.lineThrough,
                color: context.colors.onSurfaceVariantLow,
              ),
            ),
            const SizedBox(width: 4),
            Text('\$110.99', style: context.textTheme.titleSmall),
            const SizedBox(width: 8),
            AppTextButton(
              onPressed: () {},
              prefixIcon: BetterIcons.delete03Outline,
              color: SemanticColor.error,
              size: ButtonSize.medium,
            ),
          ],
        ),
      ],
    );
  }
}
