import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_orders/components/ecommerce_orders_card.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceOrdersMobile extends StatelessWidget {
  const EcommerceOrdersMobile({super.key});

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: AppTabMenuHorizontal(
                  style: TabMenuHorizontalStyle.soft,
                  tabs: [
                    TabMenuHorizontalOption(title: 'All', value: 'All'),
                    TabMenuHorizontalOption(
                      title: 'New Orders',
                      value: 'New Orders',
                      badgeNumber: 2,
                    ),
                    TabMenuHorizontalOption(
                      title: 'Shipping',
                      value: 'Shipping',
                    ),
                    TabMenuHorizontalOption(
                      title: 'Completed',
                      value: 'Completed',
                    ),
                    TabMenuHorizontalOption(
                      title: 'Cancelled',
                      value: 'Cancelled',
                    ),
                  ],
                  selectedValue: 'All',
                  onChanged: (_) {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.5,
                horizontal: 16,
              ),
              child: AppDivider(),
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
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  EcommerceOrdersCard(
                    userImage: Assets.images.avatars.illustration01.image(),
                    userName: 'Corey George',
                    orderStatusBadgeText: 'Completed',
                    orderStatusBadgeColor: SemanticColor.success,
                    paymentStatusBadgeText: 'Completed',
                    paymentStatusBadgeColor: SemanticColor.success,
                  ),
                  EcommerceOrdersCard(
                    userImage: Assets.images.avatars.illustration02.image(),
                    userName: 'Ahmad Rosser',
                    orderStatusBadgeText: 'Shipping',
                    orderStatusBadgeColor: SemanticColor.warning,
                    paymentStatusBadgeText: 'Cash on Delivery',
                    paymentStatusBadgeColor: SemanticColor.neutral,
                  ),
                  EcommerceOrdersCard(
                    userImage: Assets.images.avatars.illustration03.image(),
                    userName: 'Ahmad Siphron',
                    orderStatusBadgeText: 'Shipping',
                    orderStatusBadgeColor: SemanticColor.warning,
                    paymentStatusBadgeText: 'Cash on Delivery',
                    paymentStatusBadgeColor: SemanticColor.neutral,
                  ),
                  EcommerceOrdersCard(
                    userImage: Assets.images.avatars.illustration04.image(),
                    userName: 'Ashlynn Septimus',
                    orderStatusBadgeText: 'Completed',
                    orderStatusBadgeColor: SemanticColor.success,
                    paymentStatusBadgeText: 'Completed',
                    paymentStatusBadgeColor: SemanticColor.success,
                  ),
                  EcommerceOrdersCard(
                    userImage: Assets.images.avatars.illustration05.image(),
                    userName: 'Ann Stanton',
                    orderStatusBadgeText: 'Completed',
                    orderStatusBadgeColor: SemanticColor.success,
                    paymentStatusBadgeText: 'Completed',
                    paymentStatusBadgeColor: SemanticColor.success,
                  ),
                  EcommerceOrdersCard(
                    userImage: Assets.images.avatars.illustration06.image(),
                    userName: 'Jocelyn Franci',
                    orderStatusBadgeText: 'Cancelled',
                    orderStatusBadgeColor: SemanticColor.error,
                    paymentStatusBadgeText: 'Not Completed',
                    paymentStatusBadgeColor: SemanticColor.neutral,
                  ),
                  EcommerceOrdersCard(
                    userImage: Assets.images.avatars.illustration07.image(),
                    userName: 'Ann Levin',
                    orderStatusBadgeText: 'Completed',
                    orderStatusBadgeColor: SemanticColor.success,
                    paymentStatusBadgeText: 'Cash on Delivery',
                    paymentStatusBadgeColor: SemanticColor.neutral,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 31),
              child: AppTableFooter(isMobile: true),
            ),
          ],
        ),
      ),
    );
  }
}
