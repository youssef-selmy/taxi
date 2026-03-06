import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class EcommerceDetailsCard extends StatelessWidget {
  const EcommerceDetailsCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 16.0 : 20.0;
    final hasTitle = !isMobile;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: _cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasTitle) ...[
            Text('Details', style: context.textTheme.titleSmall),
            const SizedBox(height: 16),
          ],
          isMobile
              ? _buildMobileProductRow(context)
              : _buildDesktopProductRow(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11.5),
            child: AppDivider(),
          ),
          isMobile
              ? _buildMobileProductRow(context)
              : _buildDesktopProductRow(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.5),
            child: AppDivider(),
          ),
          // Price rows
          _buildPriceRow(context, label: 'Subtotal', value: '\$199.99'),
          _buildPriceRow(context, label: 'Shipping', value: '\$10.00'),
          _buildPriceRow(context, label: 'Discount', value: '\$0.00'),
          _buildPriceRow(context, label: 'Taxes', value: '\$10.99'),
          _buildPriceRow(
            context,
            label: 'Total',
            value: '\$10.99',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) => BoxDecoration(
    color: context.colors.surface,
    border: Border.all(color: context.colors.outline),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
  );

  Widget _buildPriceRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style:
                  isTotal
                      ? context.textTheme.titleSmall
                      : context.textTheme.bodyMedium!.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
            ),
          ),
          SizedBox(
            width: 87,
            child: Text(
              value,
              style:
                  isTotal
                      ? context.textTheme.titleSmall
                      : context.textTheme.labelLarge,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileProductRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Assets.images.products.shoe01.image(
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nike Airforce 1', style: context.textTheme.bodyMedium),
              const SizedBox(height: 2),
              Text(
                'SKU: AABBCCDD',
                style: context.textTheme.bodySmall!.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
            ],
          ),
        ),
        // Quantity
        Text('x1', style: context.textTheme.labelLarge),
        const SizedBox(width: 16),
        // Price: fixed width so numbers align to the right
        SizedBox(
          width: 95,
          child: Text(
            '\$199.99',
            style: context.textTheme.labelLarge,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopProductRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.images.products.shoe01.image(
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nike Airforce 1', style: context.textTheme.bodyMedium),
            const SizedBox(height: 2),
            Text(
              'SKU: AABBCCDD',
              style: context.textTheme.bodySmall!.copyWith(
                color: context.colors.onSurfaceVariantLow,
              ),
            ),
          ],
        ),
        const Spacer(),
        Text('x1', style: context.textTheme.labelLarge),
        const SizedBox(width: 104),
        SizedBox(
          width: 95,
          child: Text(
            '\$199.99',
            style: context.textTheme.labelLarge,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
