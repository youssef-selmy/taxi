import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products_list/components/ecommerce_product_card.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceProductsListMobile extends StatelessWidget {
  const EcommerceProductsListMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EcommerceMobileTopBar.dashboardPanel(
              prefixIcon: BetterIcons.arrowLeft01Outline,
              title: 'List',
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Products List',
                  style: context.textTheme.titleSmall,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  spacing: 8,
                  children: [
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
                        color: context.colors.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
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
                        color: context.colors.onSurfaceVariant,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    AppTextButton(
                      onPressed: () {},
                      text: 'Add Filter',
                      prefix: Icon(
                        BetterIcons.addSquareOutline,
                        size: 20,
                        color: context.colors.onSurfaceVariant,
                      ),
                      size: ButtonSize.medium,
                    ),
                    AppIconButton(
                      icon: BetterIcons.file02Outline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                    AppIconButton(
                      icon: BetterIcons.cloudDownloadOutline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                    AppIconButton(
                      icon: BetterIcons.moreVerticalCircle01Outline,
                      style: IconButtonStyle.outline,
                      size: ButtonSize.medium,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 24,
              ),
              child: Column(
                spacing: 8,
                children: [
                  EcommerceProductCard(
                    productId: '#PRD001',
                    badgeText: 'Published',
                    badgeColor: SemanticColor.success,
                    productImage: Assets.images.products.classicTShirt.image(
                      fit: BoxFit.cover,
                    ),
                    productName: 'Classic T-Shirt',
                    price: 45.99,
                    quantity: 25,
                  ),
                  EcommerceProductCard(
                    productId: '#PRD002',
                    badgeText: 'Draft',
                    badgeColor: SemanticColor.neutral,
                    productImage: Assets.images.products.hoodie.image(
                      fit: BoxFit.cover,
                    ),
                    productName: 'Hoodie',
                    price: 129.99,
                    quantity: 15,
                  ),
                  EcommerceProductCard(
                    productId: '#PRD003',
                    badgeText: 'Published',
                    badgeColor: SemanticColor.success,
                    productImage: Assets.images.products.shoe01.image(
                      fit: BoxFit.cover,
                    ),
                    productName: 'Nike Airforce',
                    price: 299.99,
                    quantity: 72,
                  ),
                  EcommerceProductCard(
                    productId: '#PRD004',
                    badgeText: 'Published',
                    badgeColor: SemanticColor.success,
                    productImage: Assets.images.products.poloShirt.image(
                      fit: BoxFit.cover,
                    ),
                    productName: 'Polo Shirt',
                    price: 89.99,
                    quantity: 72,
                  ),
                  EcommerceProductCard(
                    productId: '#PRD005',
                    badgeText: 'Published',
                    badgeColor: SemanticColor.success,
                    productImage: Assets.images.products.cargoPants.image(
                      fit: BoxFit.cover,
                    ),
                    productName: 'Cargo Pants',
                    price: 100.99,
                    quantity: 25,
                  ),
                  EcommerceProductCard(
                    productId: '#PRD006',
                    badgeText: 'Draft',
                    badgeColor: SemanticColor.neutral,
                    productImage: Assets.images.products.pufferJacket.image(
                      fit: BoxFit.cover,
                    ),
                    productName: 'Puffer Jacket',
                    price: 165.99,
                    quantity: 15,
                  ),
                  EcommerceProductCard(
                    productId: '#PRD007',
                    badgeText: 'Published',
                    badgeColor: SemanticColor.success,
                    productImage: Assets.images.products.fitJeans.image(
                      fit: BoxFit.cover,
                    ),
                    productName: 'Fit Jeans',
                    price: 99.99,
                    quantity: 72,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 68),
              child: AppTableFooter(isMobile: true),
            ),
          ],
        ),
      ),
    );
  }
}
