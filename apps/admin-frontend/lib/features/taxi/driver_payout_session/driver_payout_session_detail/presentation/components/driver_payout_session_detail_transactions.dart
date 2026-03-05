import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_account.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/blocs/driver_payout_session_detail.cubit.dart';
import 'package:better_localization/localizations.dart';

class DriverPayoutSessionDetailTransactions extends StatelessWidget {
  const DriverPayoutSessionDetailTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPayoutSessionDetailBloc>();
    return BlocBuilder<
      DriverPayoutSessionDetailBloc,
      DriverPayoutSessionDetailState
    >(
      builder: (context, state) {
        return AppDataTable(
          title: context.tr.usersList,
          columns: [
            DataColumn(label: Text(context.tr.id)),
            DataColumn(label: Text(context.tr.driver)),
            DataColumn(label: Text(context.tr.status)),
            DataColumn(label: Text(context.tr.amount)),
            DataColumn(label: Text(context.tr.payoutAccount)),
          ],
          getRowCount: (data) => data.driverTransactions.nodes.length,
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.driverTransactions.nodes[index]),
          getPageInfo: (data) => data.driverTransactions.pageInfo,
          data: state.driverTransactionsState,
          paging: state.transactionsPaging,
          onPageChanged: bloc.onTransactionsPageChanged,
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$driverTransactionPayout node,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(node.id)),
        DataCell(
          node.driver?.tableView(context) ?? Text(context.tr.unknownDriver),
        ),
        DataCell(node.status.chip(context)),
        DataCell(node.amountView(context)),
        DataCell(
          node.payoutAccount?.tableView(context) ?? Text(context.tr.unknown),
        ),
      ],
    );
  }
}
