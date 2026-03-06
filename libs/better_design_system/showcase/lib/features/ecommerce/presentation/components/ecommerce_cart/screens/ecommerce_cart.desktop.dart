import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_cart/components/ecommerce_items_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_navbar_second.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_cart/components/ecommerce_summary_card.dart';
import 'package:better_design_system/atoms/breadcrumb/breadcrumb.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class EcommerceCartDesktop extends StatelessWidget {
  const EcommerceCartDesktop({super.key, this.header});

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
              bottom: 305,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBreadcrumb(
                  separator: BreadcrumbSeparator.arrow,
                  items: [
                    BreadcrumbOption(title: 'Home', value: 'Home'),
                    BreadcrumbOption(
                      title: 'Shopping Cart',
                      value: 'Shopping Cart',
                      icon: null,
                    ),
                  ],
                  onPressed: (context) {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Shopping Cart',
                      style: context.textTheme.headlineLarge,
                    ),
                  ),
                ),
                Row(
                  spacing: 24,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: const EcommerceItemsCard()),
                    Expanded(flex: 1, child: const EcommerceSummaryCard()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
