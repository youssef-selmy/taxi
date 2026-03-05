import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/accordion/checkable_accordion_raised.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_delivery_region.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_delivery.bloc.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/dialogs/shop_detail_upsert_delivery_region_dialog.dart';
import 'package:better_icons/better_icons.dart';

class ShopDetailDeliveryTab extends StatelessWidget {
  final String shopId;
  final String shopCurrency;

  const ShopDetailDeliveryTab({
    super.key,
    required this.shopId,
    required this.shopCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailDeliveryBloc()..onStarted(shopId: shopId),
      child: BlocConsumer<ShopDetailDeliveryBloc, ShopDetailDeliveryState>(
        listenWhen: (previous, current) =>
            previous.deleteDeliveryRegionState !=
            current.deleteDeliveryRegionState,
        listener: (context, state) {
          context.showToast(
            state.deleteDeliveryRegionState.errorMessage ??
                context.tr.savedSuccessfully,
            type: state.deleteDeliveryRegionState.isError
                ? SemanticColor.error
                : SemanticColor.success,
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LargeHeader(
                  title: context.tr.ownerInformation,
                  size: HeaderSize.large,
                ),
                const SizedBox(height: 16),
                CheckableAccordionRaised(
                  onChanged: context
                      .read<ShopDetailDeliveryBloc>()
                      .onIsShopDeliveryAvailableChanged,
                  title: context.tr.shopDelivery,
                  value: state.isShopDeliveryAvailable,
                ),
                const SizedBox(height: 16),
                CheckableAccordionRaised(
                  onChanged: context
                      .read<ShopDetailDeliveryBloc>()
                      .onIsExpressDeliveryAvailableChanged,
                  title: context.tr.expressDelivery,
                  value: state.isExpressDeliveryAvailable,
                  child: AppNumberField.integer(
                    minValue: 0,
                    maxValue: 100,
                    hint: "%",
                    initialValue: state.expressDeliveryShopCommission,
                    onChanged: context
                        .read<ShopDetailDeliveryBloc>()
                        .onExpressDeliveryShopCommissionChanged,
                    title: context.tr.shopCommission,
                  ),
                ),
                const SizedBox(height: 24),
                LargeHeader(
                  title: context.tr.deliveryZones,
                  size: HeaderSize.large,
                ),
                SizedBox(
                  height: 600,
                  child: AppDataTable(
                    columns: [
                      DataColumn(label: Text(context.tr.name)),
                      DataColumn(label: Text(context.tr.price)),
                      DataColumn2(label: const SizedBox()),
                    ],
                    searchBarOptions: TableSearchBarOptions(
                      query: state.deliveryRegionsSearchQuery,
                      onChanged: context
                          .read<ShopDetailDeliveryBloc>()
                          .onDeliveryRegionsSearchQueryChanged,
                    ),
                    actions: [
                      AppOutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                ShopDetailUpsertDeliveryRegionDialog(
                                  shopId: shopId,
                                ),
                          );
                        },
                        text: context.tr.addDeliveryZone,
                        prefixIcon: BetterIcons.addCircleOutline,
                      ),
                    ],
                    getRowCount: (data) =>
                        data.shopDeliveryRegions.nodes.length,
                    rowBuilder: (data, index) => _rowBuilder(
                      context,
                      data.shopDeliveryRegions.nodes[index],
                    ),
                    getPageInfo: (data) => data.shopDeliveryRegions.pageInfo,
                    data: state.deliveryRegionsState,
                    onPageChanged: context
                        .read<ShopDetailDeliveryBloc>()
                        .onDeliveryRegionsPageChanged,
                    paging: state.deliveryRegionsPaging,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$shopDeliveryRegion node) {
    final bloc = context.read<ShopDetailDeliveryBloc>();
    return DataRow(
      cells: [
        DataCell(Text(node.name ?? "-")),
        DataCell(node.deliveryFee.toCurrency(context, shopCurrency)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                          return ShopDetailUpsertDeliveryRegionDialog(
                            shopId: shopId,
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
                    onPressed: () async {
                      final deleteOrError = await bloc.onDeleteRegionPressed(
                        regionId: node.id,
                      );
                      context.showToast(
                        deleteOrError.errorMessage ??
                            context.tr.savedSuccessfully,
                        type: deleteOrError.isError
                            ? SemanticColor.error
                            : SemanticColor.success,
                      );
                    },
                    prefixIcon: BetterIcons.delete03Outline,
                    color: SemanticColor.error,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
