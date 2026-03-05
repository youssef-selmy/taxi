import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_account.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/presentation/blocs/parking_payout_session_detail.cubit.dart';
import 'package:better_localization/localizations.dart';

class ParkingPayoutSessionDetailTransactions extends StatelessWidget {
  const ParkingPayoutSessionDetailTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingPayoutSessionDetailBloc>();
    return BlocBuilder<
      ParkingPayoutSessionDetailBloc,
      ParkingPayoutSessionDetailState
    >(
      builder: (context, state) {
        return AppDataTable(
          title: context.tr.usersList,
          columns: [
            DataColumn(label: Text(context.tr.id)),
            DataColumn(label: Text(context.tr.parking)),
            DataColumn(label: Text(context.tr.status)),
            DataColumn(label: Text(context.tr.amount)),
            DataColumn(label: Text(context.tr.payoutAccount)),
          ],
          getRowCount: (data) => data.parkingTransactions.nodes.length,
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.parkingTransactions.nodes[index]),
          getPageInfo: (data) => data.parkingTransactions.pageInfo,
          data: state.parkingTransactionsState,
          paging: state.transactionsPaging,
          onPageChanged: bloc.onParkingTransactionsPageChanged,
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$parkingTransactionPayout node,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(node.id)),
        DataCell(node.customer.tableView(context)),
        DataCell(node.status.chip(context)),
        DataCell(node.amountView(context)),
        DataCell(
          node.payoutAccount?.tableView(context) ?? Text(context.tr.unknown),
        ),
      ],
    );
  }
}
