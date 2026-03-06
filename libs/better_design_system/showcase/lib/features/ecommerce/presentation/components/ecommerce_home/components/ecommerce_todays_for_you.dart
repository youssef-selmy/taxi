import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_item.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class EcommerceTodaysForYou extends StatelessWidget {
  const EcommerceTodaysForYou({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Todays For You', style: context.textTheme.titleMedium),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AppTabMenuHorizontal(
                  style: TabMenuHorizontalStyle.soft,
                  tabs: [
                    TabMenuHorizontalOption(
                      title: 'Featured items',
                      value: 'Featured items',
                    ),
                    TabMenuHorizontalOption(
                      title: 'Best seller',
                      value: 'Best seller',
                    ),
                    TabMenuHorizontalOption(
                      title: 'Special Discount',
                      value: 'Special Discount',
                    ),
                    TabMenuHorizontalOption(
                      title: 'Keep Stylish',
                      value: 'Keep Stylish',
                    ),
                  ],
                  selectedValue: 'Featured items',
                  onChanged: (context) {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: [
                SizedBox(
                  width: 176,
                  child: EcommerceItem.simple(
                    image: Assets.images.products.image06.image(),
                    category: 'Short',
                    description: 'Short Cas',
                    currentPrice: '\$20',
                  ),
                ),
                SizedBox(
                  width: 176,
                  child: EcommerceItem.simple(
                    image: Assets.images.products.image07.image(),
                    category: 'Shirt',
                    description: 'Tommy Jeans Jersey Tee',
                    currentPrice: '\$20',
                  ),
                ),
                SizedBox(
                  width: 176,
                  child: EcommerceItem.simple(
                    image: Assets.images.products.image08.image(),
                    category: 'Top',
                    description: 'SLEEVELESS FNK',
                    currentPrice: '\$20',
                  ),
                ),
                SizedBox(
                  width: 176,
                  child: EcommerceItem.simple(
                    image: Assets.images.products.image09.image(),
                    category: 'Jacket',
                    description:
                        'Down trekking jacket with Primaloft Silver filling - grey',
                    currentPrice: '\$20',
                  ),
                ),
                SizedBox(
                  width: 176,
                  child: EcommerceItem.simple(
                    image: Assets.images.products.image10.image(),
                    category: 'Vests',
                    description: 'Synthetic-fill down vest - olive',
                    currentPrice: '\$20',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Text('Todays For You', style: context.textTheme.titleLarge),
            const Spacer(),
            AppTabMenuHorizontal(
              style: TabMenuHorizontalStyle.soft,
              tabs: [
                TabMenuHorizontalOption(
                  title: 'Featured items',
                  value: 'Featured items',
                ),
                TabMenuHorizontalOption(
                  title: 'Best seller',
                  value: 'Best seller',
                ),
                TabMenuHorizontalOption(
                  title: 'Special Discount',
                  value: 'Special Discount',
                ),
                TabMenuHorizontalOption(
                  title: 'Keep Stylish',
                  value: 'Keep Stylish',
                ),
              ],
              selectedValue: 'Featured items',
              onChanged: (context) {},
            ),
          ],
        ),

        const SizedBox(height: 24),
        Row(
          spacing: 24,
          children: [
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image06.image(),
                category: 'Short',
                description: 'Short Cas',
                currentPrice: '\$20',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image07.image(),
                category: 'Shirt',
                description: 'Tommy Jeans Jersey Tee',
                currentPrice: '\$20',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image08.image(),
                category: 'Top',
                description: 'SLEEVELESS FNK',
                currentPrice: '\$20',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image09.image(),
                category: 'Jacket',
                description:
                    'Down trekking jacket with Primaloft Silver filling - grey',
                currentPrice: '\$20',
              ),
            ),
            Expanded(
              child: EcommerceItem.simple(
                image: Assets.images.products.image10.image(),
                category: 'Vests',
                description: 'Synthetic-fill down vest - olive',
                currentPrice: '\$20',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
