import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/components/ecommerce_customer_info_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/components/ecommerce_details_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/components/ecommerce_history_card.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceOrderDetailsMobile extends StatelessWidget {
  const EcommerceOrderDetailsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EcommerceMobileTopBar.dashboardPanel(
              prefixIcon: BetterIcons.menu01Outline,
              title: 'Orders',
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 20,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.surfaceVariantLow,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order #SD009',
                              style: context.textTheme.titleSmall,
                            ),
                            Text(
                              '30 May, 2025',
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        AppIconButton(
                          icon: BetterIcons.pencilEdit02Outline,
                          style: IconButtonStyle.outline,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Details', style: context.textTheme.titleSmall),
                  const SizedBox(height: 16),
                  const EcommerceDetailsCard(isMobile: true),
                  const SizedBox(height: 20),
                  Text('History', style: context.textTheme.titleSmall),
                  const SizedBox(height: 16),
                  const EcommerceHistoryCard(isMobile: true),
                  const SizedBox(height: 20),
                  Text('Customer Info', style: context.textTheme.titleSmall),
                  const SizedBox(height: 16),
                  const EcommerceCustomerInfoCard(isMobile: true),
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
                    text: 'Order Packed',
                    size: ButtonSize.extraLarge,
                  ),
                  AppOutlinedButton(
                    onPressed: () {},
                    text: 'Print',
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
