import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceSummaryCard extends StatelessWidget {
  const EcommerceSummaryCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
        boxShadow:
            isMobile
                ? [BetterShadow.shadow4.toBoxShadow(context)]
                : [BetterShadow.shadow16.toBoxShadow(context)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary', style: context.textTheme.titleMedium),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text('\$231.98', style: context.textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping Cost',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text('\$10.00', style: context.textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text('-\$11.00', style: context.textTheme.bodyLarge),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tax',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text('\$0', style: context.textTheme.bodyLarge),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11.5),
            child: AppDivider(),
          ),
          SizedBox(
            width: double.infinity,
            child: AppTextButton(
              onPressed: () {},
              text: 'Apply Discount Code',
              prefixIcon: BetterIcons.discountFilled,
              suffixIcon: BetterIcons.arrowRight01Outline,
              color: SemanticColor.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11.5),
            child: AppDivider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: context.textTheme.titleMedium),
              Text('\$230.98', style: context.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: AppFilledButton(
              onPressed: () {},
              text: 'Checkout',
              size: ButtonSize.extraLarge,
            ),
          ),
        ],
      ),
    );
  }
}
