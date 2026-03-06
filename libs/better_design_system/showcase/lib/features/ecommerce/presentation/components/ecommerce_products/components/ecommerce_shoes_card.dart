import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_item.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceShoesCard extends StatelessWidget {
  const EcommerceShoesCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shoes', style: context.textTheme.titleMedium),
              AppIconButton(
                icon: BetterIcons.filterVerticalOutline,
                style: IconButtonStyle.outline,
                iconColor: context.colors.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            spacing: 8,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image11.image(),
                      category: 'Shoes',
                      description: 'Air Jordan 1 Low SE',
                      currentPrice: '\$110.99',
                    ),
                  ),
                  Expanded(
                    child: EcommerceItem.discount(
                      image: Assets.images.products.image12.image(),
                      category: 'Shoes',
                      description: 'New Balance 740 skor...',
                      currentPrice: '\$99.00',
                      originalPrice: '\$110.99',
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: EcommerceItem.discount(
                      image: Assets.images.products.image13.image(),
                      category: 'Shoes',
                      description: 'Vans',
                      currentPrice: '\$99.00',
                      originalPrice: '\$110.99',
                    ),
                  ),
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image14.image(),
                      category: 'Shoes',
                      description: 'SPEED HIKER high trekking boots - black',
                      currentPrice: '\$110.99',
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image15.image(),
                      category: 'Shoes',
                      description: 'Air Jordan 1 Low SE',
                      currentPrice: '\$110.99',
                    ),
                  ),
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image16.image(),
                      category: 'Shoes',
                      description: 'Nike Air Force 1 \'07',
                      currentPrice: '\$110.99',
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image17.image(),
                      category: 'Shoes',
                      description: 'Samba OG Skor...',
                      currentPrice: '\$110.99',
                    ),
                  ),
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image18.image(),
                      category: 'Shoes',
                      description: 'New Balance 2002R skor...',
                      currentPrice: '\$110.99',
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image19.image(),
                      category: 'Shoes',
                      description: 'Nike Streakfly 2',
                      currentPrice: '\$110.99',
                    ),
                  ),
                  Expanded(
                    child: EcommerceItem.simple(
                      image: Assets.images.products.image20.image(),
                      category: 'Shoes',
                      description: 'Nike Pegasus 41',
                      currentPrice: '\$110.99',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              Text('Shoes', style: context.textTheme.headlineLarge),
              const Spacer(),
              AppOutlinedButton(
                onPressed: () {},
                text: 'Sort',
                color: SemanticColor.neutral,
                size: ButtonSize.medium,
                prefix: Icon(
                  BetterIcons.arrowUpDownOutline,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
                suffix: Icon(
                  BetterIcons.arrowDown01Outline,
                  size: 20,
                  color: context.colors.onSurfaceVariantLow,
                ),
                foregroundColor: context.colors.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              AppOutlinedButton(
                onPressed: () {},
                text: 'Filter',
                color: SemanticColor.neutral,
                size: ButtonSize.medium,
                prefix: Icon(
                  BetterIcons.filterHorizontalOutline,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
                suffix: Icon(
                  BetterIcons.arrowDown01Outline,
                  size: 20,
                  color: context.colors.onSurfaceVariantLow,
                ),
                foregroundColor: context.colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
        Row(
          spacing: 24,
          children: [
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image11.image(),
                category: 'Shoes',
                description: 'Air Jordan 1 Low SE',
                currentPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.discount(
                image: Assets.images.products.image12.image(),
                category: 'Shoes',
                description: 'New Balance 740 skor...',
                currentPrice: '\$99.00',
                originalPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.discount(
                image: Assets.images.products.image13.image(),
                category: 'Shoes',
                description: 'Vans',
                currentPrice: '\$99.00',
                originalPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image14.image(),
                category: 'Shoes',
                description: 'SPEED HIKER high trekking boots - black',
                currentPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image15.image(),
                category: 'Shoes',
                description: 'Air Jordan 1 Low SE',
                currentPrice: '\$110.99',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          spacing: 24,
          children: [
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image16.image(),
                category: 'Shoes',
                description: 'Nike Air Force 1 \'07',
                currentPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image17.image(),
                category: 'Shoes',
                description: 'Samba OG Skor...',
                currentPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image18.image(),
                category: 'Shoes',
                description: 'New Balance 2002R skor...',
                currentPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image19.image(),
                category: 'Shoes',
                description: 'Nike Streakfly 2',
                currentPrice: '\$110.99',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image20.image(),
                category: 'Shoes',
                description: 'Nike Pegasus 41',
                currentPrice: '\$110.99',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
