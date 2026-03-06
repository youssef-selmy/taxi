import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_category_item.dart';
import 'package:flutter/material.dart';

class EcommerceCategoryBar extends StatelessWidget {
  const EcommerceCategoryBar({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EcommerceCategoryItem(
              label: 'Men',
              isMobile: true,
              svgPicture: Assets.images.clothes.tShirt.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Women',
              isMobile: true,
              svgPicture: Assets.images.clothes.dress03.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Kids',
              isMobile: true,
              svgPicture: Assets.images.clothes.baby01.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Activewear',
              isMobile: true,
              svgPicture: Assets.images.clothes.sleeveless.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Outerwear',
              isMobile: true,
              svgPicture: Assets.images.clothes.hoodie.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Loungewear',
              isMobile: true,
              svgPicture: Assets.images.clothes.turtleNeck.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Workwear',
              isMobile: true,
              svgPicture: Assets.images.clothes.suit02.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Accessories',
              isMobile: true,
              svgPicture: Assets.images.clothes.neckles.svg(),
            ),
            EcommerceCategoryItem(
              label: 'Footwear',
              isMobile: true,
              svgPicture: Assets.images.clothes.runningShoes.svg(),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EcommerceCategoryItem(
          label: 'Men',
          svgPicture: Assets.images.clothes.tShirt.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Women',
          svgPicture: Assets.images.clothes.dress03.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Kids',
          svgPicture: Assets.images.clothes.baby01.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Activewear',
          svgPicture: Assets.images.clothes.sleeveless.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Outerwear',
          svgPicture: Assets.images.clothes.hoodie.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Loungewear',
          svgPicture: Assets.images.clothes.turtleNeck.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Workwear',
          svgPicture: Assets.images.clothes.suit02.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Accessories',
          svgPicture: Assets.images.clothes.neckles.svg(),
        ),
        EcommerceCategoryItem(
          label: 'Footwear',
          svgPicture: Assets.images.clothes.runningShoes.svg(),
        ),
      ],
    );
  }
}
