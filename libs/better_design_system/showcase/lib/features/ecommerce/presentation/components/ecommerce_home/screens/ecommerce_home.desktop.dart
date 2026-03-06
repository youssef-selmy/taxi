import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_category_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_gray_container.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_hot_sale_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_navbar_second.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/components/ecommerce_todays_for_you.dart';
import 'package:flutter/material.dart';

class EcommerceHomeDesktop extends StatelessWidget {
  const EcommerceHomeDesktop({super.key, this.header});

  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        const EcommerceNavbarSecond(),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32,
                left: 108,
                right: 108,
                bottom: 100,
              ),
              child: Column(
                children: [
                  const EcommerceGrayContainer(height: 517),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: const EcommerceCategoryBar(),
                  ),
                  const EcommerceHotSaleCard(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: Row(
                      spacing: 24,
                      children: [
                        Expanded(
                          child: Column(
                            spacing: 16,
                            children: [
                              const EcommerceGrayContainer(
                                height: 362,
                                showControls: false,
                              ),
                              const EcommerceGrayContainer(
                                height: 209,
                                showControls: false,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 16,
                            children: [
                              const EcommerceGrayContainer(
                                height: 215,
                                showControls: false,
                              ),
                              const EcommerceGrayContainer(
                                height: 356,
                                showControls: false,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const EcommerceTodaysForYou(),
                  const SizedBox(height: 64),
                  const EcommerceGrayContainer(
                    height: 362,
                    showControls: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
