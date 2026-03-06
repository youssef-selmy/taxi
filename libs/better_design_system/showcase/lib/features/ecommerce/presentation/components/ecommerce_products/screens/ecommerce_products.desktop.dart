import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_navbar_second.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products/components/ecommerce_shoes_card.dart';
import 'package:better_design_system/atoms/breadcrumb/breadcrumb.dart';
import 'package:flutter/material.dart';

class EcommerceProductsDesktop extends StatelessWidget {
  const EcommerceProductsDesktop({super.key, this.header});

  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        const EcommerceNavbarSecond(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 35,
              left: 108,
              right: 108,
              bottom: 230,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppBreadcrumb(
                    separator: BreadcrumbSeparator.arrow,
                    items: [
                      BreadcrumbOption(title: 'Home', value: 'Home'),
                      BreadcrumbOption(title: 'Men', value: 'Men', icon: null),
                      BreadcrumbOption(
                        title: 'Shoes',
                        value: 'Shoes',
                        icon: null,
                      ),
                    ],
                    onPressed: (context) {},
                  ),
                ),
                const EcommerceShoesCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
