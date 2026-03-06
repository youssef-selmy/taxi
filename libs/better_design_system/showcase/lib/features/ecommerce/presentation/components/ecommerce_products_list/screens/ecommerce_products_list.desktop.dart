import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products_list/components/ecommerce_orders_list_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_sidebar.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceProductsListDesktop extends StatelessWidget {
  const EcommerceProductsListDesktop({super.key, this.header});

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 358,
                            child: AppTextField(
                              borderRadius: BorderRadius.circular(24),
                              density: TextFieldDensity.noDense,
                              hint: 'Search anything',
                              prefixIcon: Icon(
                                BetterIcons.search01Filled,
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const Spacer(),
                          AppNavbarIcon(
                            size: ButtonSize.medium,
                            icon: BetterIcons.notification02Outline,
                            badgeNumber: 2,
                            borderRadius: BorderRadius.circular(50),
                            iconSize: 24,
                          ),
                          const SizedBox(width: 12),
                          AppOutlinedButton(
                            onPressed: () {},
                            text: 'View Shop',
                            prefixIcon: BetterIcons.store01Outline,
                            color: SemanticColor.neutral,
                            foregroundColor: context.colors.onSurface,
                            size: ButtonSize.large,
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Products List',
                              style: context.textTheme.titleSmall,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 267,
                              child: AppTextField(
                                isFilled: false,
                                hint: 'Search by name',
                                prefixIcon: Icon(BetterIcons.search01Filled),
                                density: TextFieldDensity.noDense,
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.5),
                        child: AppDivider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              AppOutlinedButton(
                                onPressed: () {},
                                text: 'Sort',
                                color: SemanticColor.neutral,
                                size: ButtonSize.medium,
                                prefix: Icon(
                                  BetterIcons.arrowUpDownOutline,
                                  size: 18,
                                  color: context.colors.onSurfaceVariant,
                                ),
                                suffix: Icon(
                                  BetterIcons.arrowDown01Outline,
                                  size: 18,
                                  color: context.colors.onSurfaceVariant,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17.5,
                                ),
                                child: Container(
                                  width: 1,
                                  decoration: BoxDecoration(
                                    color: context.colors.outline,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              AppOutlinedButton(
                                onPressed: () {},
                                text: 'Filter',
                                color: SemanticColor.neutral,
                                size: ButtonSize.medium,
                                prefix: Icon(
                                  BetterIcons.filterHorizontalOutline,
                                  size: 18,
                                  color: context.colors.onSurfaceVariant,
                                ),
                                suffix: Icon(
                                  BetterIcons.arrowDown01Outline,
                                  size: 18,
                                  color: context.colors.onSurfaceVariant,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              const SizedBox(width: 8),
                              AppTextButton(
                                onPressed: () {},
                                text: 'Add Filter',
                                prefix: Icon(
                                  BetterIcons.addSquareOutline,
                                  size: 18,
                                  color: context.colors.onSurfaceVariant,
                                ),
                                size: ButtonSize.medium,
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17.5,
                                ),
                                child: Container(
                                  width: 1,
                                  decoration: BoxDecoration(
                                    color: context.colors.outline,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              AppIconButton(
                                icon: BetterIcons.file02Outline,
                                isCircular: true,
                                style: IconButtonStyle.outline,
                                size: ButtonSize.medium,
                              ),
                              const SizedBox(width: 8),
                              AppIconButton(
                                icon: BetterIcons.cloudDownloadOutline,
                                isCircular: true,
                                style: IconButtonStyle.outline,
                                size: ButtonSize.medium,
                              ),
                              const SizedBox(width: 8),
                              AppIconButton(
                                icon: BetterIcons.moreVerticalCircle01Outline,
                                isCircular: true,
                                style: IconButtonStyle.outline,
                                size: ButtonSize.medium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 450, child: EcommerceOrdersListCard()),
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
