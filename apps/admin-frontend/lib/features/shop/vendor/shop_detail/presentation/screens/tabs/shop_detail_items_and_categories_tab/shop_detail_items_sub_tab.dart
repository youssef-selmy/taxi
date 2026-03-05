import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_items.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/dialogs/shop_detail_upsert_item_dialog.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailItemsSubTab extends StatelessWidget {
  final String shopId;
  final String shopCurrency;

  const ShopDetailItemsSubTab({
    super.key,
    required this.shopId,
    required this.shopCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailItemsBloc()..onStarted(shopId: shopId),
      child: BlocBuilder<ShopDetailItemsBloc, ShopDetailItemsState>(
        builder: (context, state) {
          return Column(
            children: [
              LargeHeader(title: context.tr.items, size: HeaderSize.large),
              const SizedBox(height: 12),
              Expanded(
                child: AppDataTable(
                  actions: [
                    AppOutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ShopDetailUpsertItemDialog(
                              shopId: shopId,
                              itemId: null,
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
                        .read<ShopDetailItemsBloc>()
                        .onSearchQueryChanged,
                  ),
                  columns: [
                    DataColumn(label: Text(context.tr.name)),
                    DataColumn(label: Text(context.tr.price)),
                    DataColumn(label: Text(context.tr.categories)),
                    DataColumn(label: Text(context.tr.presets)),
                    DataColumn(label: const SizedBox()),
                  ],
                  getRowCount: (data) => data.items.nodes.length,
                  rowBuilder: (data, index) =>
                      _rowBuilder(context, data.items.nodes[index]),
                  getPageInfo: (data) => data.items.pageInfo,
                  data: state.itemsState,
                  paging: state.paging,
                  onPageChanged: context
                      .read<ShopDetailItemsBloc>()
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

  DataRow _rowBuilder(BuildContext context, Fragment$shopItemListItem node) {
    final bloc = context.read<ShopDetailItemsBloc>();
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              if (node.image != null) ...[
                node.image!.roundedWidget(size: 40, radius: 4),
                const SizedBox(width: 4),
              ],
              Text(node.name, style: context.textTheme.labelMedium),
            ],
          ),
        ),
        DataCell(
          Text(
            node.basePrice.formatCurrency(shopCurrency),
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(node.categories.toChips()),
        DataCell(
          Text(
            node.presets.map((e) => e.name).join(", "),
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
                      return ShopDetailUpsertItemDialog(
                        shopId: shopId,
                        itemId: node.id,
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
