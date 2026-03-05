import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';

class ItemCategoriesTabBar extends StatelessWidget {
  const ItemCategoriesTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectItemsBloc, SelectItemsState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.items.isLoading,

          // child: TabBarBordered<String>(
          //   selectedValue: state.selectedItemCategoryId,
          //   onSelected: (value) {
          // context.read<SelectItemsBloc>().selectItemCategory(
          //       categoryId: value,
          //     );
          //   },
          // items: state.items.data
          //         ?.map(
          //           (e) => TabBarItem(
          //             title: e.name,
          //             value: e.id,
          //           ),
          //         )
          //         .toList() ??
          //       List.generate(5, (i) => i)
          //           .map(
          //             (e) => TabBarItem(
          //               title: 'Category $e',
          //               value: e.toString(),
          //             ),
          //           )
          //           .toList(),
          // ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AppTabMenuHorizontal(
              style: TabMenuHorizontalStyle.soft,
              tabs:
                  state.items.data
                      ?.map(
                        (e) =>
                            TabMenuHorizontalOption(title: e.name, value: e.id),
                      )
                      .toList() ??
                  List.generate(5, (i) => i)
                      .map(
                        (e) => TabMenuHorizontalOption(
                          title: '${context.tr.category} $e',
                          value: e.toString(),
                        ),
                      )
                      .toList(),
              selectedValue: state.selectedItemCategoryId,
              onChanged: (value) {
                context.read<SelectItemsBloc>().selectItemCategory(
                  categoryId: value,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
