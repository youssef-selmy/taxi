import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_navbar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_orders/components/ecommerce_orders_table.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_sidebar.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceOrdersDesktop extends StatelessWidget {
  const EcommerceOrdersDesktop({super.key, this.header});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EcommerceNavbar.dashboardPanelRounded(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Orders',
                              style: context.textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTabMenuHorizontal(
                                  style: TabMenuHorizontalStyle.soft,
                                  tabs: [
                                    TabMenuHorizontalOption(
                                      title: 'All',
                                      value: 'All',
                                    ),
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
                                  onChanged: (String value) {},
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 258,
                                  child: AppTextField(
                                    hint: 'Search by  name',
                                    prefixIcon: Icon(
                                      BetterIcons.search01Filled,
                                    ),
                                    density: TextFieldDensity.noDense,
                                    isFilled: false,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 17.5,
                              ),
                              child: AppDivider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16,
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 17.5,
                                      ),
                                      child: Container(
                                        width: 1,
                                        decoration: BoxDecoration(
                                          color: context.colors.outline,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppIconButton(
                                      icon: BetterIcons.file02Outline,
                                      style: IconButtonStyle.outline,
                                      size: ButtonSize.medium,
                                    ),
                                    const SizedBox(width: 12),
                                    AppIconButton(
                                      icon: BetterIcons.cloudDownloadOutline,
                                      style: IconButtonStyle.outline,
                                      size: ButtonSize.medium,
                                    ),
                                    const SizedBox(width: 12),
                                    AppIconButton(
                                      icon:
                                          BetterIcons
                                              .moreVerticalCircle01Outline,
                                      style: IconButtonStyle.outline,
                                      size: ButtonSize.medium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const EcommerceOrdersTable(),
                            const SizedBox(height: 16),
                            const AppTableFooter(),
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
