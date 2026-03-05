import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/item_card.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/item_categories_tab_bar.dart';

class ItemsGrid extends StatelessWidget {
  const ItemsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectItemsBloc, SelectItemsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ItemCategoriesTabBar(),
            const SizedBox(height: 16),
            Expanded(
              child: Skeletonizer(
                enabled: state.shops.isLoading,
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 228,
                    crossAxisCount: context.isDesktop ? 5 : 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount:
                      state.selectedItemCategory?.subItems.nodes.length ?? 10,
                  itemBuilder: (context, index) {
                    if (state.items.isLoading) {
                      return ItemCard(
                        item: mockShopItemListItem2,
                        currency: Env.defaultCurrency,
                      );
                    }
                    final item =
                        state.selectedItemCategory?.subItems.nodes[index];
                    if (item == null) {
                      return const SizedBox.shrink();
                    }
                    return ItemCard(
                      item: item,
                      currency:
                          state.selectedShop?.currency ?? Env.defaultCurrency,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
