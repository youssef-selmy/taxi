import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products/components/ecommerce_shoes_card.dart';
import 'package:better_design_system/atoms/breadcrumb/breadcrumb.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceProductsMobile extends StatelessWidget {
  const EcommerceProductsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EcommerceMobileTopBar.clientSide(
              prefixIcon: BetterIcons.location01Outline,
              title: 'Cordova',
              suffixIcons: [
                BetterIcons.search01Filled,
                BetterIcons.menu01Outline,
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 8,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: AppBreadcrumb(
                  separator: BreadcrumbSeparator.arrow,
                  items: [
                    BreadcrumbOption(title: 'Men', value: 'Men', icon: null),
                    BreadcrumbOption(
                      title: 'Shoes',
                      value: 'Shoes',
                      icon: null,
                    ),
                  ],
                  onPressed: (_) {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 17,
              ),
              child: Column(
                children: [const EcommerceShoesCard(isMobile: true)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
