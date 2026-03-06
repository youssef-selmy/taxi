import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_category_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_description_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_pricing_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_product_images_card.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceProductsDetailsMobile extends StatelessWidget {
  const EcommerceProductsDetailsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                bottom: 76,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  const EcommerceDescriptionCard(isMobile: true),
                  const EcommerceProductImagesCard(isMobile: true),
                  const EcommerceCategoryCard(isMobile: true),
                  const EcommercePricingCard(isMobile: true),
                ],
              ),
            ),
            AppDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 3,
                    decoration: BoxDecoration(
                      color: context.colors.outlineVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppFilledButton(
                    onPressed: () {},
                    text: 'Publish',
                    size: ButtonSize.extraLarge,
                  ),
                  AppOutlinedButton(
                    onPressed: () {},
                    text: 'Schedule',
                    color: SemanticColor.neutral,
                    size: ButtonSize.extraLarge,
                  ),

                  AppTextButton(
                    onPressed: () {},
                    text: 'Save as Draft',
                    color: SemanticColor.neutral,
                    size: ButtonSize.extraLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
