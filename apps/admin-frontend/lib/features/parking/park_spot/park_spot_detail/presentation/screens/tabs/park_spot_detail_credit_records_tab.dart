import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/enums/parking_transaction_sort_fields.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/features/parking_insert_transaction/presentation/screens/parking_insert_transaction_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_credit_records.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ParkSpotDetailCreditRecordsTab extends StatelessWidget {
  final String parkSpotId;
  final String ownerId;

  const ParkSpotDetailCreditRecordsTab({
    super.key,
    required this.parkSpotId,
    required this.ownerId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkSpotDetailCreditRecordsBloc()
            ..onStarted(parkSpotId: parkSpotId, ownerId: ownerId),
      child:
          BlocConsumer<
            ParkSpotDetailCreditRecordsBloc,
            ParkSpotDetailCreditRecordsState
          >(
            listenWhen: (previous, current) =>
                previous.exportState != current.exportState,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<
                      ParkSpotDetailCreditRecordsBloc,
                      ParkSpotDetailCreditRecordsState
                    >(
                      builder: (context, state) {
                        return WalletBalanceCard(items: state.walletState);
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.tr.transactions,
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                        AppFilledButton(
                          text: context.tr.export,
                          onPressed: () {
                            context
                                .read<ParkSpotDetailCreditRecordsBloc>()
                                .export(Enum$ExportFormat.CSV);
                          },
                          prefixIcon: BetterIcons.share08Outline,
                        ),
                        const SizedBox(width: 8),
                        AppOutlinedButton(
                          onPressed: () {
                            context
                                .read<ParkSpotDetailCreditRecordsBloc>()
                                .export(Enum$ExportFormat.PDF);
                          },
                          text: context.tr.print,
                          color: SemanticColor.neutral,
                        ),
                        const SizedBox(width: 8),
                        AppOutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              useSafeArea: false,
                              builder: (context) =>
                                  ParkingInsertTransactionDialog(
                                    parkingId: parkSpotId,
                                  ),
                            );
                          },
                          text: context.tr.insert,
                          prefixIcon: BetterIcons.addCircleOutline,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 550,
                      child:
                          BlocBuilder<
                            ParkSpotDetailCreditRecordsBloc,
                            ParkSpotDetailCreditRecordsState
                          >(
                            builder: (context, state) {
                              return AppDataTable(
                                sortOptions: _buildSortOptions(context, state),
                                filterOptions: [
                                  _buildStatusFilter(context, state),
                                  _buildActionFilter(context, state),
                                ],
                                columns: [
                                  DataColumn2(
                                    label: Text(context.tr.dateAndTime),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn(
                                    label: Text(context.tr.transactionType),
                                  ),
                                  DataColumn(
                                    label: Text(context.tr.paymentMethod),
                                  ),
                                  DataColumn2(
                                    label: Text(context.tr.amount),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Text(context.tr.status),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn(
                                    label: Text(context.tr.referenceNumber),
                                  ),
                                ],
                                getRowCount: (data) =>
                                    data.parkingTransactions.nodes.length,
                                rowBuilder: (data, index) {
                                  final transaction =
                                      data.parkingTransactions.nodes[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          transaction.createdAt.formatDateTime,
                                        ),
                                      ),
                                      DataCell(
                                        transaction.tableViewType(context),
                                      ),
                                      DataCell(
                                        transaction.tableViewPaymentMethod(
                                          context,
                                        ),
                                      ),
                                      DataCell(transaction.amountView(context)),
                                      DataCell(
                                        transaction.status.chip(context),
                                      ),
                                      DataCell(
                                        Text(transaction.documentNumber ?? ""),
                                      ),
                                    ],
                                  );
                                },
                                getPageInfo: (data) =>
                                    data.parkingTransactions.pageInfo,
                                data: state.creditRecordsState,
                                paging: state.paging,
                                onPageChanged: context
                                    .read<ParkSpotDetailCreditRecordsBloc>()
                                    .onPageChanged,
                              );
                            },
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }

  AppFilterDropdown<Enum$TransactionStatus> _buildStatusFilter(
    BuildContext context,
    ParkSpotDetailCreditRecordsState state,
  ) {
    return AppFilterDropdown<Enum$TransactionStatus>(
      onChanged: context
          .read<ParkSpotDetailCreditRecordsBloc>()
          .onTransactionStatusFilterChanged,
      selectedValues: state.statusFilters,
      title: context.tr.status,
      items: [
        FilterItem(label: context.tr.done, value: Enum$TransactionStatus.Done),
        FilterItem(
          label: context.tr.processing,
          value: Enum$TransactionStatus.Processing,
        ),
      ],
    );
  }

  AppFilterDropdown<Enum$TransactionType> _buildActionFilter(
    BuildContext context,
    ParkSpotDetailCreditRecordsState state,
  ) {
    return AppFilterDropdown<Enum$TransactionType>(
      onChanged: context
          .read<ParkSpotDetailCreditRecordsBloc>()
          .onTransactionActionFilterChanged,
      selectedValues: state.typeFilters,
      title: context.tr.transactionType,
      items: [
        FilterItem<Enum$TransactionType>(
          label: context.tr.credit,
          value: Enum$TransactionType.Credit,
        ),
        FilterItem<Enum$TransactionType>(
          label: context.tr.debit,
          value: Enum$TransactionType.Debit,
        ),
      ],
    );
  }

  AppSortDropdown<Input$ParkingTransactionSort> _buildSortOptions(
    BuildContext context,
    ParkSpotDetailCreditRecordsState state,
  ) {
    return AppSortDropdown<Input$ParkingTransactionSort>(
      labelGetter: (p0) => p0.field.tableViewSortLabel(context, p0.direction),
      onChanged: (selectedItems) => context
          .read<ParkSpotDetailCreditRecordsBloc>()
          .onTransactionSortChanged(selectedItems),
      selectedValues: state.sorting,
      items: [
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.type,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.type,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.id,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.id,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.amount,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.amount,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.status,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.status,
          direction: Enum$SortDirection.DESC,
        ),
      ],
    );
  }
}
