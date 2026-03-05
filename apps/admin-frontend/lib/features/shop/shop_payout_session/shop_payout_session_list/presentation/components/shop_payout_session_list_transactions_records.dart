import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/shop_transaction_sort_fields.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/data/graphql/shop_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/blocs/shop_payout_session_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopPayoutSessionListTransactionsRecords extends StatelessWidget {
  const ShopPayoutSessionListTransactionsRecords({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopPayoutSessionListBloc>();
    return BlocBuilder<ShopPayoutSessionListBloc, ShopPayoutSessionListState>(
      builder: (context, state) {
        return AppDataTable(
          title: context.tr.financialRecords,
          filterOptions: [
            AppFilterDropdown<Enum$TransactionStatus>(
              title: context.tr.status,
              items: Enum$TransactionStatus.values.filterItems(context),
              onChanged: bloc.onStatusFilterChanged,
            ),
          ],
          columns: [
            DataColumn(label: Text(context.tr.type)),
            DataColumn(label: Text(context.tr.dateAndTime)),
            DataColumn(label: Text(context.tr.amount)),
            DataColumn(label: Text(context.tr.status)),
            DataColumn(label: Text(context.tr.referenceNumber)),
          ],
          sortOptions: _tableSortOptions(context),
          getRowCount: (data) => data.payoutTransactions.nodes.length,
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.payoutTransactions.nodes[index]),
          getPageInfo: (data) => data.payoutTransactions.pageInfo,
          data: state.payoutTransactionsState,
          paging: state.sessionsPaging,
          onPageChanged: bloc.onTransactionsPageChanged,
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$shopsPayoutTransactions$payoutTransactions$nodes node,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              AppAvatar(imageUrl: node.shop.image?.address),
              const SizedBox(width: 8),
              Text(node.shop.name, style: context.textTheme.labelMedium),
            ],
          ),
        ),
        DataCell(Text(node.createdAt.formatDateTime)),
        DataCell(node.amountView(context)),
        DataCell(node.status.chip(context)),
        DataCell(
          Text(
            node.documentNumber ?? "-",
            style: context.textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  AppSortDropdown<Input$ShopTransactionSort> _tableSortOptions(
    BuildContext context,
  ) {
    final bloc = context.read<ShopPayoutSessionListBloc>();
    return AppSortDropdown(
      onChanged: bloc.transactionSortChanged,
      items: [
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.type,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.type,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.id,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.id,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.status,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.status,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.amount,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopTransactionSort(
          field: Enum$ShopTransactionSortFields.amount,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      labelGetter: (item) =>
          item.field.tableViewSortLabel(context, item.direction),
    );
  }
}
