import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/enums/shop_order_sort_fields.dart';
import 'package:admin_frontend/core/enums/shop_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_orders.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/dialogs/shop_detail_order_detail_dialog.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopDetailOrdersHistoryTab extends StatelessWidget {
  final String shopId;

  const ShopDetailOrdersHistoryTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopDetailOrdersBloc, ShopDetailOrdersState>(
      builder: (context, state) {
        final bloc = context.read<ShopDetailOrdersBloc>();
        return AppDataTable(
          title: context.tr.orderHistory,
          data: state.ordersHistoryState,
          getPageInfo: (data) => data.shopOrders.pageInfo,
          getRowCount: (data) => data.shopOrders.nodes.length,
          paging: state.historyPaging,
          onPageChanged: bloc.onHistoryPageChanged,
          sortOptions: _buildSortOptions(context, state),
          filterOptions: [_buildStatusFilter(context, state)],
          columns: [
            DataColumn2(label: Text(context.tr.id), fixedWidth: 60),
            DataColumn(label: Text(context.tr.customer)),
            DataColumn2(
              label: Text(context.tr.dateAndTime),
              size: ColumnSize.S,
            ),
            DataColumn2(label: Text(context.tr.total), size: ColumnSize.S),
            DataColumn(label: Text(context.tr.paymentMethod)),
            DataColumn2(label: Text(context.tr.status), size: ColumnSize.S),
          ],
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.shopOrders.nodes[index]),
        );
      },
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$shopOrderListItem node) {
    return DataRow(
      onSelectChanged: (_) {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) =>
              ShopDetailOrderDetailDialog(orderId: node.id, shopId: shopId),
        );
      },
      cells: [
        DataCell(
          Text(
            "#${node.id}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.customer.tableView(context)),
        DataCell(Text(node.createdAt.formatDateTime)),
        DataCell(node.total.toCurrency(context, node.currency)),
        DataCell(
          node.paymentMethod.tableViewPaymentMethod(
            context,
            node.savedPaymentMethod,
            node.paymentGateway,
          ),
        ),
        DataCell(node.status.chip(context)),
      ],
    );
  }

  AppSortDropdown<Input$ShopOrderSort> _buildSortOptions(
    BuildContext context,
    ShopDetailOrdersState state,
  ) {
    return AppSortDropdown(
      selectedValues: state.sorting,
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
          field: Enum$ShopOrderSortFields.total,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopOrderSort(
          field: Enum$ShopOrderSortFields.total,
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
        Input$ShopOrderSort(
          field: Enum$ShopOrderSortFields.paymentMethod,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopOrderSort(
          field: Enum$ShopOrderSortFields.paymentMethod,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      labelGetter: (sort) =>
          sort.field.tableViewSortLabel(context, sort.direction),
    );
  }

  AppFilterDropdown<Enum$ShopOrderStatus> _buildStatusFilter(
    BuildContext context,
    ShopDetailOrdersState state,
  ) {
    return AppFilterDropdown<Enum$ShopOrderStatus>(
      onChanged: context.read<ShopDetailOrdersBloc>().onStatusFilterChanged,
      selectedValues: state.statusFilter,
      title: context.tr.status,
      items: Enum$ShopOrderStatus.values.toFilterItems(context),
    );
  }
}
