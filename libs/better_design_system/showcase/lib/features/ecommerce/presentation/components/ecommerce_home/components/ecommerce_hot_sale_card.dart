import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_item.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceHotSaleCard extends StatelessWidget {
  const EcommerceHotSaleCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 16.0 : 24.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariantLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile ? _buildMobileHeader(context) : _buildDesktopHeader(context),
          if (!isMobile) const SizedBox(height: 24),
          isMobile
              ? _buildMobileItemsList(context)
              : _buildDesktopItemsList(context),
        ],
      ),
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              BetterIcons.flashFilled,
              color: context.colors.error,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text('Hot Sale', style: context.textTheme.titleMedium),
            const Spacer(),
            AppTextButton(
              onPressed: () {},
              text: 'See All',
              color: SemanticColor.primary,
              size: ButtonSize.small,
              suffixIcon: BetterIcons.arrowRight02Outline,
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCountdown(context),
      ],
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return Row(
      children: [
        Icon(BetterIcons.flashFilled, color: context.colors.error),
        const SizedBox(width: 8),
        Text('Hot Sale', style: context.textTheme.titleLarge),
        const SizedBox(width: 16),
        _buildCountdown(context),
        const Spacer(),
        AppTextButton(
          onPressed: () {},
          text: 'See All',
          color: SemanticColor.primary,
          size: ButtonSize.medium,
          suffixIcon: BetterIcons.arrowRight02Outline,
        ),
      ],
    );
  }

  Widget _buildCountdown(BuildContext context) {
    return Row(
      children: [
        Text(
          'Ends in',
          style: context.textTheme.bodySmall!.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        AppBadge(
          text: '23:59:59',
          size: BadgeSize.large,
          color: SemanticColor.error,
          style: BadgeStyle.fill,
          isRounded: true,
        ),
      ],
    );
  }

  Widget _buildMobileItemsList(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 14,
            children: [
              SizedBox(
                width: 176,
                child: EcommerceItem.discount(
                  image: Assets.images.products.image01.image(),
                  category: 'Hoodie',
                  description: 'Pullover hoodie - black',
                  currentPrice: '\$110.99',
                  originalPrice: '\$120.00',
                ),
              ),
              SizedBox(
                width: 176,
                child: EcommerceItem.discount(
                  image: Assets.images.products.image02.image(),
                  category: 'Hat',
                  description:
                      'Nike Running Juniper Trail 2 Gore-TEX trainers in light grey',
                  currentPrice: '\$110.99',
                  originalPrice: '\$120.00',
                ),
              ),
              SizedBox(
                width: 176,
                child: EcommerceItem.discount(
                  image: Assets.images.products.image03.image(),
                  category: 'Shoes',
                  description: 'New Balance',
                  currentPrice: '\$110.99',
                  originalPrice: '\$120.00',
                ),
              ),
              SizedBox(
                width: 176,
                child: EcommerceItem.discount(
                  image: Assets.images.products.image04.image(),
                  category: 'Bag',
                  description: 'Under Armour HUSTLE SPORT - Rucksack',
                  currentPrice: '\$110.99',
                  originalPrice: '\$120.00',
                ),
              ),
              SizedBox(
                width: 176,
                child: EcommerceItem.discount(
                  image: Assets.images.products.image05.image(),
                  category: 'Shoes',
                  description: 'Vans',
                  currentPrice: '\$110.99',
                  originalPrice: '\$120.00',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopItemsList(BuildContext context) {
    return Row(
      spacing: 14,
      children: [
        Expanded(
          child: EcommerceItem.discount(
            image: Assets.images.products.image01.image(),
            category: 'Hoodie',
            description: 'Pullover hoodie - black',
            currentPrice: '\$110.99',
            originalPrice: '\$120.00',
          ),
        ),
        Expanded(
          child: EcommerceItem.discount(
            image: Assets.images.products.image02.image(),
            category: 'Hat',
            description:
                'Nike Running Juniper Trail 2 Gore-TEX trainers in light grey',
            currentPrice: '\$110.99',
            originalPrice: '\$120.00',
          ),
        ),
        Expanded(
          child: EcommerceItem.discount(
            image: Assets.images.products.image03.image(),
            category: 'Shoes',
            description: 'New Balance',
            currentPrice: '\$110.99',
            originalPrice: '\$120.00',
          ),
        ),
        Expanded(
          child: EcommerceItem.discount(
            image: Assets.images.products.image04.image(),
            category: 'Bag',
            description: 'Under Armour HUSTLE SPORT - Rucksack',
            currentPrice: '\$110.99',
            originalPrice: '\$120.00',
          ),
        ),
        Expanded(
          child: EcommerceItem.discount(
            image: Assets.images.products.image05.image(),
            category: 'Shoes',
            description: 'Vans',
            currentPrice: '\$110.99',
            originalPrice: '\$120.00',
          ),
        ),
      ],
    );
  }
}
