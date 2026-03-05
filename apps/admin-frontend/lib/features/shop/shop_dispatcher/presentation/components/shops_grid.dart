import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/shop_card.dart';

class ShopsGrid extends StatelessWidget {
  const ShopsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectItemsBloc, SelectItemsState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.shops.isLoading,
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: 100),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 200,
              crossAxisCount: (context.width / 350).round(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 0,
            ),
            itemCount: state.shops.data?.length ?? 12,
            itemBuilder: (context, index) {
              if (state.shops.isLoading) {
                return ShopCard(shop: mockFragmentShop);
              }
              final shop = state.shops.data?[index];
              return ShopCard(
                shop: shop ?? mockFragmentShop,
                onTap: (shop) {
                  context.read<SelectItemsBloc>().selectShop(shop: shop);
                },
              );
            },
          ),
        );
      },
    );
  }
}
