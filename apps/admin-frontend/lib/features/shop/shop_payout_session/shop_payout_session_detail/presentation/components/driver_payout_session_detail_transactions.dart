import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_account.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_detail/presentation/blocs/shop_payout_session_detail.cubit.dart';
import 'package:better_localization/localizations.dart';

class ShopPayoutSessionDetailTransactions extends StatelessWidget {
  const ShopPayoutSessionDetailTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopPayoutSessionDetailBloc>();
    return BlocBuilder<
      ShopPayoutSessionDetailBloc,
      ShopPayoutSessionDetailState
    >(
      builder: (context, state) {
        return AppDataTable(
          title: context.tr.usersList,
          columns: [
            DataColumn(label: Text(context.tr.id)),
            DataColumn(label: Text(context.tr.shop)),
            DataColumn(label: Text(context.tr.status)),
            DataColumn(label: Text(context.tr.amount)),
            DataColumn(label: Text(context.tr.payoutAccount)),
          ],
          getRowCount: (data) => data.shopTransactions.nodes.length,
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.shopTransactions.nodes[index]),
          getPageInfo: (data) => data.shopTransactions.pageInfo,
          data: state.shopTransactionsState,
          paging: state.transactionsPaging,
          onPageChanged: bloc.onShopTransactionsPageChanged,
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$shopTransactionPayout node,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(node.id)),
        DataCell(node.shop.tableView(context)),
        DataCell(node.status.chip(context)),
        DataCell(node.amountView(context)),
        DataCell(
          node.payoutAccount?.tableView(context) ?? Text(context.tr.unknown),
        ),
      ],
    );
  }
}
