import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_items_and_categories.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_items_and_categories_tab/shop_detail_categories_sub_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_items_and_categories_tab/shop_detail_items_sub_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_items_and_categories_tab/shop_detail_presets_sub_tab.dart';

class ShopDetailItemsAndCategoriesTab extends StatelessWidget {
  final String shopId;

  const ShopDetailItemsAndCategoriesTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailItemsAndCategoriesBloc(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<
            ShopDetailItemsAndCategoriesBloc,
            ShopDetailItemsAndCategoriesState
          >(
            builder: (context, state) {
              return AppToggleSwitchButtonGroup<int>(
                selectedValue: state.selectedTab,
                onChanged: context
                    .read<ShopDetailItemsAndCategoriesBloc>()
                    .onTabSelected,
                options: [
                  ToggleSwitchButtonGroupOption(
                    label: context.tr.presets,
                    value: 0,
                  ),
                  ToggleSwitchButtonGroupOption(
                    label: context.tr.categories,
                    value: 1,
                  ),
                  ToggleSwitchButtonGroupOption(
                    label: context.tr.items,
                    value: 2,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Expanded(
            child:
                BlocBuilder<
                  ShopDetailItemsAndCategoriesBloc,
                  ShopDetailItemsAndCategoriesState
                >(
                  builder: (context, state) {
                    return PageView(
                      controller: state.pageController,
                      onPageChanged: context
                          .read<ShopDetailItemsAndCategoriesBloc>()
                          .onPageChanged,
                      children: [
                        ShopDetailPresetsSubTab(shopId: shopId),
                        ShopDetailCategoriesSubTab(shopId: shopId),
                        BlocBuilder<ShopDetailBloc, ShopDetailState>(
                          builder: (context, state) {
                            return ShopDetailItemsSubTab(
                              shopId: shopId,
                              shopCurrency:
                                  state.shopDetailState.data!.currency,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}
