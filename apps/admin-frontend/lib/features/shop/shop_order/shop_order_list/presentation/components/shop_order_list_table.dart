import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/shop_order_sort_fields.dart';
import 'package:admin_frontend/core/enums/shop_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/graphql/shop_order_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/presentation/blocs/shop_order_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopOrderListTable extends StatelessWidget {
  const ShopOrderListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopOrderListBloc>();
    return BlocBuilder<ShopOrderListBloc, ShopOrderListState>(
      builder: (context, state) {
        return AppDataTable(
          searchBarOptions: TableSearchBarOptions(
            onChanged: bloc.onQueryChanged,
          ),
          columns: [
            DataColumn2(
              label: Text(
                context.tr.id,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              fixedWidth: 70,
            ),
            DataColumn2(
              label: Text(
                context.tr.customer,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                context.tr.shop,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text(
                context.tr.dateAndTime,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
            DataColumn(
              label: Text(
                context.tr.price,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
            DataColumn(
              label: Text(
                context.tr.status,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
          ],
          sortOptions: AppSortDropdown(
            selectedValues: state.sorting,
            onChanged: (value) {
              bloc.onSortingChanged(value);
            },
            items: [
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.id,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.id,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.customerId,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.customerId,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.paymentMethod,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.paymentMethod,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.status,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.status,
                direction: Enum$SortDirection.DESC,
              ),
            ],
            labelGetter: (item) =>
                item.field.tableViewSortLabel(context, item.direction),
          ),
          filterOptions: [
            AppFilterDropdown<Fragment$shopCategory>(
              title: context.tr.shopCategories,
              selectedValues: state.listShopCategoryFilter,
              onChanged: bloc.onShopCategoryFilterChanged,
              items:
                  state.shopCategories.data?.shopCategories.nodes
                      .map(
                        (category) =>
                            FilterItem(label: category.name, value: category),
                      )
                      .toList() ??
                  [],
            ),
            AppFilterDropdown<Enum$ShopOrderStatus>(
              title: context.tr.status,
              selectedValues: state.shopOrderStatus,
              onChanged: bloc.onStatusFilterChanged,
              items: Enum$ShopOrderStatus.values
                  .where((e) => e != Enum$ShopOrderStatus.$unknown)
                  .map(
                    (status) =>
                        FilterItem(label: status.name(context), value: status),
                  )
                  .toList(),
            ),
          ],
          getRowCount: (data) => data.shopOrders.nodes.length,
          rowBuilder: (data, int index) =>
              rowBuilder(context, state.shopOrderList.data!, index),
          getPageInfo: (Query$shopOrders data) => data.shopOrders.pageInfo,
          data: state.shopOrderList,
          paging: state.paging,
          onPageChanged: bloc.onPageChanged,
        );
      },
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$shopOrders data, int index) {
  final shopOrder = data.shopOrders.nodes[index];
  return DataRow(
    onSelectChanged: (value) {
      context.router.push(ShopOrderDetailRoute(shopOrderId: shopOrder.id));
    },
    cells: [
      DataCell(
        Text(
          '#${shopOrder.id}',
          style: context.textTheme.labelMedium?.variant(context),
        ),
      ),
      DataCell(
        AppProfileCell(
          name: shopOrder.customer.fullName,
          imageUrl: shopOrder.customer.media?.address,
        ),
      ),
      DataCell(
        shopOrder.carts.length == 1
            ? Row(
                children: [
                  AppAvatar(
                    imageUrl: shopOrder.carts[0].shop.image?.address,
                    size: AvatarSize.size40px,
                  ),
                  const SizedBox(width: 8),
                  Text(shopOrder.carts[0].shop.name),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: shopOrder.carts.mapIndexed((index, item) {
                  return Positioned(
                    left: index * 25.0,
                    child: AppAvatar(
                      imageUrl: item.shop.image?.address,
                      size: AvatarSize.size40px,
                    ),
                  );
                }).toList(),
              ),
      ),
      DataCell(
        Text(
          shopOrder.createdAt.formatDateTime,
          style: context.textTheme.labelMedium?.apply(),
        ),
      ),
      DataCell(shopOrder.total.toCurrency(context, shopOrder.currency)),
      DataCell(shopOrder.status.chip(context)),
    ],
  );
}
