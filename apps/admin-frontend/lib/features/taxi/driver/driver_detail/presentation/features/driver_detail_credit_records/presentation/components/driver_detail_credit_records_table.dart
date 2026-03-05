import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/molecules/table_cells/transaction_amount_cell.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/enums/driver_transaction_sort_fields.dart';
import 'package:admin_frontend/core/enums/transaction_action.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/data/graphql/driver_detail_credit_records.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/presentation/blocs/driver_detail_credit_records.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DriverDetailCreditRecordsTable extends StatelessWidget {
  const DriverDetailCreditRecordsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverDetailCreditRecordsBloc>();
    return BlocBuilder<
      DriverDetailCreditRecordsBloc,
      DriverDetailCreditRecordsState
    >(
      builder: (context, state) {
        return BlocConsumer<
          DriverDetailCreditRecordsBloc,
          DriverDetailCreditRecordsState
        >(
          listenWhen: (_, state) =>
              state.exportState is ApiResponseLoaded ||
              state.exportState is ApiResponseError,
          listener: (context, state) {
            switch (state.exportState) {
              case ApiResponseLoaded(:final data):
                context.showSuccess(context.tr.successExportMessage);
                launchUrlString(data);
                break;

              case ApiResponseError():
                context.showFailure(state.exportState);
                break;

              default:
                break;
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  WalletBalanceCard(items: state.driverWalletsState),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        context.tr.transactions,
                        style: context.textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      AppFilledButton(
                        prefixIcon: BetterIcons.share08Outline,
                        text: context.tr.export,
                        onPressed: () {
                          bloc.onExport(Enum$ExportFormat.CSV);
                        },
                      ),
                      const SizedBox(width: 8),
                      AppOutlinedButton(
                        text: context.tr.print,
                        onPressed: () {
                          bloc.onExport(Enum$ExportFormat.PDF);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 420,
                    child: AppDataTable(
                      columns: [
                        DataColumn(label: Text(context.tr.dateAndTime)),
                        DataColumn2(label: Text(context.tr.transactionType)),
                        DataColumn2(
                          label: Text(context.tr.paymentMethod),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(label: Text(context.tr.amount)),
                        DataColumn(label: Text(context.tr.status)),
                        DataColumn(label: Text(context.tr.referenceNumber)),
                      ],
                      sortOptions: AppSortDropdown<Input$DriverTransactionSort>(
                        selectedValues: state.sorting,
                        onChanged: (value) {
                          bloc.onSortingChanged(value);
                        },
                        items: [
                          Input$DriverTransactionSort(
                            field: Enum$DriverTransactionSortFields.action,
                            direction: Enum$SortDirection.ASC,
                          ),
                          Input$DriverTransactionSort(
                            field: Enum$DriverTransactionSortFields.action,
                            direction: Enum$SortDirection.DESC,
                          ),
                          Input$DriverTransactionSort(
                            field: Enum$DriverTransactionSortFields.amount,
                            direction: Enum$SortDirection.ASC,
                          ),
                          Input$DriverTransactionSort(
                            field: Enum$DriverTransactionSortFields.amount,
                            direction: Enum$SortDirection.DESC,
                          ),
                          Input$DriverTransactionSort(
                            field: Enum$DriverTransactionSortFields.createdAt,
                            direction: Enum$SortDirection.ASC,
                          ),
                          Input$DriverTransactionSort(
                            field: Enum$DriverTransactionSortFields.createdAt,
                            direction: Enum$SortDirection.DESC,
                          ),
                        ],
                        labelGetter: (item) => item.field.tableViewSortLabel(
                          context,
                          item.direction,
                        ),
                      ),
                      filterOptions: [
                        AppFilterDropdown<Enum$TransactionAction>(
                          title: context.tr.transactionType,
                          selectedValues: state.transactionActionFilter,
                          onChanged: bloc.onTransactionFilterChanged,
                          items: Enum$TransactionAction.values
                              .where(
                                (e) => e != Enum$TransactionAction.$unknown,
                              )
                              .map(
                                (status) => FilterItem(
                                  label: status.name(context),
                                  value: status,
                                ),
                              )
                              .toList(),
                        ),
                        AppFilterDropdown<Enum$TransactionStatus>(
                          title: context.tr.status,
                          selectedValues: state.transactionStatusFilter,
                          onChanged: bloc.onStatusFilterChanged,
                          items: Enum$TransactionStatus.values.filterItems(
                            context,
                          ),
                        ),
                      ],
                      getRowCount: (data) =>
                          data.driverTransactions.nodes.length,
                      rowBuilder: (data, index) =>
                          rowBuilder(context, data, index),
                      getPageInfo: (data) => data.driverTransactions.pageInfo,
                      data: state.driverCreditRecordsState,
                      paging: state.paging,
                      onPageChanged: bloc.onPageChanged,
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  DataRow rowBuilder(
    BuildContext context,
    Query$driverCreditRecords data,
    int index,
  ) {
    final driverTransaction = data.driverTransactions.nodes[index];
    return DataRow(
      onSelectChanged: (value) {},
      cells: [
        DataCell(Text(driverTransaction.createdAt.formatDateTime)),
        DataCell(
          Row(
            children: [
              driverTransaction.action.icon(context),
              const SizedBox(width: 4),
              Text(driverTransaction.action.name(context)),
            ],
          ),
        ),
        DataCell(
          driverTransaction.savedPaymentMethod?.tableView(context) ??
              Text(context.tr.notSet),
        ),
        DataCell(
          AppTransactionAmountCell(
            amount: driverTransaction.amount,
            currency: driverTransaction.currency,
          ),
        ),
        DataCell(driverTransaction.status.chip(context)),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              driverTransaction.refrenceNumber ?? '',
              style: context.textTheme.labelMedium,
            ),
          ),
        ),
      ],
    );
  }
}
