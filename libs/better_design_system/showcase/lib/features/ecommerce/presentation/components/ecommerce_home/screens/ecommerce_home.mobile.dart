import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_bottom_nav.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_category_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_gray_container.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_hot_sale_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_todays_for_you.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceHomeMobile extends StatelessWidget {
  const EcommerceHomeMobile({super.key});

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
                bottom: 29,
              ),
              child: Column(
                children: [
                  const EcommerceGrayContainer(
                    height: 164,
                    showControls: false,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: context.colors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: context.colors.surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: context.colors.surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    spacing: 24,
                    children: [
                      const EcommerceCategoryBar(isMobile: true),
                      const EcommerceHotSaleCard(isMobile: true),
                      Column(
                        children: [
                          const EcommerceGrayContainer(
                            height: 164,
                            showControls: false,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 8,
                            children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  color: context.colors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  color: context.colors.surfaceVariant,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  color: context.colors.surfaceVariant,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                  color: context.colors.surfaceVariant,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const EcommerceTodaysForYou(isMobile: true),
                      const EcommerceGrayContainer(
                        height: 361,
                        showControls: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const EcommerceBottomNav(),
          ],
        ),
      ),
    );
  }
}
