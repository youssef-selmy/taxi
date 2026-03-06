import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_category_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_description_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_navbar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_pricing_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/components/ecommerce_product_images_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_sidebar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceProductDetailsDesktop extends StatelessWidget {
  const EcommerceProductDetailsDesktop({super.key, this.header});

  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EcommerceSidebar(selectedItem: EcommerceSidebarPage.products),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EcommerceNavbar.dashboardPanelRounded(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 24,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextButton(
                              onPressed: () {},
                              text: 'Back',
                              color: SemanticColor.neutral,
                              prefix: Icon(BetterIcons.arrowLeft02Outline),
                              size: ButtonSize.medium,
                            ),
                            const Spacer(),
                            AppTextButton(
                              onPressed: () {},
                              text: 'Save as Draft',
                              color: SemanticColor.neutral,
                              size: ButtonSize.medium,
                            ),
                            const SizedBox(width: 8),
                            AppOutlinedButton(
                              onPressed: () {},
                              text: 'Schedule',
                              color: SemanticColor.neutral,
                              size: ButtonSize.medium,
                            ),
                            const SizedBox(width: 8),
                            AppFilledButton(
                              onPressed: () {},
                              text: 'Publish',
                              size: ButtonSize.medium,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                          bottom: 24,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24,
                          children: [
                            Expanded(
                              child: Column(
                                spacing: 24,
                                children: [
                                  const EcommerceDescriptionCard(),
                                  const EcommerceCategoryCard(),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 24,
                                children: [
                                  const EcommerceProductImagesCard(),
                                  const EcommercePricingCard(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
