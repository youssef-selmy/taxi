import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_bottom_nav.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_cart/components/ecommerce_items_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_cart/components/ecommerce_summary_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceCartMobile extends StatelessWidget {
  const EcommerceCartMobile({super.key});

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
                top: 16,
                bottom: 38,
              ),
              child: Column(
                spacing: 24,
                children: [
                  const EcommerceItemsCard(isMobile: true),
                  const EcommerceSummaryCard(isMobile: true),
                ],
              ),
            ),
            EcommerceBottomNav(selectedItem: EcommerceNavRoute.shippingCart),
          ],
        ),
      ),
    );
  }
}
