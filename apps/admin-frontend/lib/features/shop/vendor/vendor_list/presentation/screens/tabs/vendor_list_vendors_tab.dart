import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/enums/shop_order_queue_level.dart';
import 'package:admin_frontend/core/enums/shop_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/presentation/blocs/vendor_list.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class VendorListVendorsTab extends StatelessWidget {
  const VendorListVendorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VendorListBloc>();
    return BlocBuilder<VendorListBloc, VendorListState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Skeletonizer(
                enabled: state.vendorCategoriesState.isLoading,
                enableSwitchAnimation: true,
                child: AppTabMenuHorizontal(
                  style: TabMenuHorizontalStyle.soft,
                  tabs:
                      state.vendorCategoriesState.data?.shopCategories.nodes
                          .map(
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
                    bloc.onCategoryTabChanged(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AppDataTable(
                  minWidth: 1200,
                  fixedLeftColumns: 1,
                  columns: [
                    DataColumn2(
                      label: Text(context.tr.name),
                      size: context.isDesktop ? ColumnSize.L : ColumnSize.S,
                    ),
                    DataColumn(label: Text(context.tr.mobileNumber)),
                    DataColumn2(
                      label: Text(context.tr.rating),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(context.tr.orderQueue),
                      size: ColumnSize.S,
                    ),
                    DataColumn(label: Text(context.tr.categories)),
                    DataColumn(label: Text(context.tr.walletBalance)),
                    DataColumn(label: Text(context.tr.totalOrders)),
                  ],
                  searchBarOptions: TableSearchBarOptions(
                    onChanged: bloc.onSearchChanged,
                    query: state.searchQuery,
                  ),
                  actions: [
                    AppOutlinedButton(
                      onPressed: () {
                        context.router.push(VendorCreateRoute());
                      },
                      prefixIcon: BetterIcons.addCircleOutline,
                      text: context.tr.add,
                    ),
                  ],
                  sortOptions: AppSortDropdown(
                    selectedValues: state.sorting,
                    onChanged: bloc.onSortChanged,
                    items: [
                      Input$ShopSort(
                        field: Enum$ShopSortFields.id,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$ShopSort(
                        field: Enum$ShopSortFields.id,
                        direction: Enum$SortDirection.DESC,
                      ),
                      Input$ShopSort(
                        field: Enum$ShopSortFields.name,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$ShopSort(
                        field: Enum$ShopSortFields.name,
                        direction: Enum$SortDirection.DESC,
                      ),
                    ],
                    labelGetter: (sort) =>
                        sort.field.tableViewSortLabel(context, sort.direction),
                  ),
                  getRowCount: (data) => data.shops.nodes.length,
                  rowBuilder: (data, index) =>
                      _rowBuilder(context, data.shops.nodes[index]),
                  getPageInfo: (data) => data.shops.pageInfo,
                  data: state.vendorsState,
                  paging: state.paging,
                  onPageChanged: bloc.onPageChanged,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$shopListItem node) {
    return DataRow(
      onSelectChanged: (value) =>
          context.router.push(ShopDetailRoute(shopId: node.id)),
      cells: [
        DataCell(node.tableView(context)),
        DataCell(
          AppLinkButton(
            onPressed: () {
              launchUrlString("tel:+${node.mobileNumber.number}");
            },
            text: node.mobileNumber.number.formatPhoneNumber(null),
            alwaysUnderline: false,
          ),
        ),
        DataCell(RatingIndicator(rating: node.ratingAggregate?.rating)),
        DataCell(node.orderQueueLevel.toChip(context)),
        DataCell(node.categories.toChips()),
        DataCell(node.wallet.toWalletBalanceItems().balanceText(context)),
        DataCell(
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: node.carts.totalCount.toString(),
                  style: context.textTheme.labelMedium,
                ),
                TextSpan(
                  text: " ${context.tr.orders}",
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
