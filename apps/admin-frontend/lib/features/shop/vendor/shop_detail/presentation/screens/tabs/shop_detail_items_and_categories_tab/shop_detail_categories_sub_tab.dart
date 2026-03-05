import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_categories.bloc.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/dialogs/shop_detail_upsert_category_dialog.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailCategoriesSubTab extends StatelessWidget {
  final String shopId;

  const ShopDetailCategoriesSubTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopDetailCategoriesBloc()..onStarted(shopId: shopId),
      child: BlocBuilder<ShopDetailCategoriesBloc, ShopDetailCategoriesState>(
        builder: (context, state) {
          return Column(
            children: [
              LargeHeader(title: context.tr.categories, size: HeaderSize.large),
              const SizedBox(height: 24),
              Expanded(
                child: AppDataTable(
                  actions: [
                    AppOutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShopDetailUpsertCategoryDialog(
                              shopId: shopId,
                              categoryId: null,
                            );
                          },
                        );
                      },
                      text: context.tr.add,
                      prefixIcon: BetterIcons.addCircleOutline,
                    ),
                  ],
                  searchBarOptions: TableSearchBarOptions(
                    query: state.searchQuery,
                    onChanged: context
                        .read<ShopDetailCategoriesBloc>()
                        .onSearchQueryChanged,
                  ),
                  columns: [
                    DataColumn(label: Text(context.tr.name)),
                    DataColumn(label: Text(context.tr.items)),
                    DataColumn(label: const SizedBox()),
                  ],
                  getRowCount: (data) => data.itemCategories.nodes.length,
                  rowBuilder: (data, index) =>
                      _rowBuilder(context, data.itemCategories.nodes[index]),
                  getPageInfo: (data) => data.itemCategories.pageInfo,
                  data: state.categoriesState,
                  paging: state.paging,
                  onPageChanged: context
                      .read<ShopDetailCategoriesBloc>()
                      .onPageChanged,
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$shopItemCategoryListItem node,
  ) {
    final bloc = context.read<ShopDetailCategoriesBloc>();
    return DataRow(
      cells: [
        DataCell(Text(node.name, style: context.textTheme.labelMedium)),
        DataCell(
          Text(
            "${node.products.totalCount} ${context.tr.itemsInPreset}",
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppTextButton(
                text: null,
                onPressed: () {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (context) {
                      return ShopDetailUpsertCategoryDialog(
                        shopId: shopId,
                        categoryId: node.id,
                      );
                    },
                  );
                },
                prefixIcon: BetterIcons.eyeFilled,
                color: SemanticColor.neutral,
              ),
              const SizedBox(width: 20),
              AppTextButton(
                text: null,
                onPressed: () => bloc.onDeletePressed(categoryId: node.id),
                prefixIcon: BetterIcons.delete03Outline,
                color: SemanticColor.error,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
