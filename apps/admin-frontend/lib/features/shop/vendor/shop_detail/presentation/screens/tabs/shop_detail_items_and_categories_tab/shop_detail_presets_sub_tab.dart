import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_presets.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/dialogs/shop_detail_upsert_preset_dialog.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailPresetsSubTab extends StatelessWidget {
  final String shopId;

  const ShopDetailPresetsSubTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailPresetsBloc()..onStarted(shopId: shopId),
      child: BlocBuilder<ShopDetailPresetsBloc, ShopDetailPresetsState>(
        builder: (context, state) {
          return Column(
            children: [
              LargeHeader(title: context.tr.presets, size: HeaderSize.large),
              Expanded(
                child: AppDataTable(
                  actions: [
                    AppOutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShopDetailUpsertPresetDialog(
                            shopId: shopId,
                            presetId: null,
                          ),
                        );
                      },
                      text: context.tr.add,
                      prefixIcon: BetterIcons.addCircleOutline,
                    ),
                  ],
                  searchBarOptions: TableSearchBarOptions(
                    onChanged: context
                        .read<ShopDetailPresetsBloc>()
                        .onSearchQueryChanged,
                  ),
                  columns: [
                    DataColumn(label: Text(context.tr.name)),
                    DataColumn(label: Text(context.tr.items)),
                    DataColumn(label: const SizedBox()),
                  ],
                  getRowCount: (data) => data.shopItemPresets.nodes.length,
                  rowBuilder: (data, index) =>
                      _rowBuilder(context, data.shopItemPresets.nodes[index]),
                  getPageInfo: (data) => data.shopItemPresets.pageInfo,
                  data: state.presetsState,
                  paging: state.paging,
                  onPageChanged: context
                      .read<ShopDetailPresetsBloc>()
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
    Fragment$shopItemPresetListItem node,
  ) {
    final bloc = context.read<ShopDetailPresetsBloc>();
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
                    builder: (context) => ShopDetailUpsertPresetDialog(
                      shopId: shopId,
                      presetId: node.id,
                    ),
                  );
                },
                prefixIcon: BetterIcons.eyeFilled,
                color: SemanticColor.neutral,
              ),
              const SizedBox(width: 20),
              AppTextButton(
                text: null,
                onPressed: () => bloc.onDeletePressed(presetId: node.id),
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
