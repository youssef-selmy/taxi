import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/components/ecommerce_customer_info_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/components/ecommerce_details_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/components/ecommerce_history_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_navbar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_sidebar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceOrderDetailsDesktop extends StatelessWidget {
  const EcommerceOrderDetailsDesktop({super.key, this.header});

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
              EcommerceSidebar(selectedItem: EcommerceSidebarPage.orders),
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
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextButton(
                                  onPressed: () {},
                                  text: 'Back',
                                  color: SemanticColor.neutral,
                                  prefix: Icon(BetterIcons.arrowLeft02Outline),
                                  size: ButtonSize.medium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order #SD009',
                                        style: context.textTheme.titleSmall,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '30 May, 2025',
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                              color:
                                                  context
                                                      .colors
                                                      .onSurfaceVariant,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      AppIconButton(
                                        icon: BetterIcons.pencilEdit02Outline,
                                        style: IconButtonStyle.outline,
                                      ),
                                      const SizedBox(width: 12),
                                      AppOutlinedButton(
                                        onPressed: () {},
                                        prefixIcon: BetterIcons.file01Outline,
                                        text: 'Print',
                                        color: SemanticColor.neutral,
                                      ),
                                      const SizedBox(width: 12),
                                      AppFilledButton(
                                        onPressed: () {},
                                        text: 'Order Packed',
                                        suffixIcon:
                                            BetterIcons.arrowDown01Outline,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    spacing: 24,
                                    children: [
                                      const EcommerceDetailsCard(),
                                      const EcommerceCustomerInfoCard(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 24,
                                    children: [const EcommerceHistoryCard()],
                                  ),
                                ),
                              ],
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
