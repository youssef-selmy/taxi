import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';
import 'package:better_localization/localizations.dart';

class ShopCategoriesTabBar extends StatelessWidget {
  const ShopCategoriesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectItemsBloc, SelectItemsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AppTabMenuHorizontal(
            style: TabMenuHorizontalStyle.soft,
            tabs:
                state.shopCategories.data
                    ?.map(
                      (e) => TabMenuHorizontalOption(
                        showArrow: false,
                        title: e.name,
                        value: e.id,
                        prefixWidget: e.image == null
                            ? null
                            : CachedNetworkImage(
                                imageUrl: e.image!.address,
                                width: 24,
                                height: 24,
                                fit: BoxFit.cover,
                              ),
                      ),
                    )
                    .toList() ??
                List.generate(5, (i) => i)
                    .map(
                      (e) => TabMenuHorizontalOption(
                        title: '${context.tr.category} $e',
                        value: e.toString(),
                        showArrow: false,
                      ),
                    )
                    .toList(),
            selectedValue: state.selectedShopCategoryId,
            onChanged: (value) {
              context.read<SelectItemsBloc>().changeShopCategory(
                categoryId: value,
              );
            },
          ),
        );
      },
    );
  }
}
