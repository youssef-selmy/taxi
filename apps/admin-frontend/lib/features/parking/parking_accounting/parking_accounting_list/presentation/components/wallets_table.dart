import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/data/graphql/parking_accounting_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_list/presentation/blocs/parking_accounting_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingAccountingListWalletsTable extends StatelessWidget {
  const ParkingAccountingListWalletsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingAccountingListBloc>();
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previousState, currentState) =>
          previousState.supportedCurrencies !=
          previousState.supportedCurrencies,
      builder: (context, stateAuth) {
        return BlocBuilder<
          ParkingAccountingListBloc,
          ParkingAccountingListState
        >(
          builder: (context, state) {
            return AppDataTable(
              minWidth: 500,
              columns: [
                DataColumn2(label: Text(context.tr.id), fixedWidth: 60),
                DataColumn(label: Text(context.tr.parking)),
                DataColumn(label: Text(context.tr.walletBalance)),
              ],
              filterOptions: [
                AppFilterDropdown<String>(
                  title: context.tr.currency,
                  selectedValues: state.selectedCurrency == null
                      ? null
                      : [state.selectedCurrency!],
                  onChanged: bloc.changeCurrency,
                  items: stateAuth.supportedCurrencies
                      .map(
                        (currency) =>
                            FilterItem(value: currency, label: currency),
                      )
                      .toList(),
                ),
              ],
              sortOptions: AppSortDropdown(
                onChanged: bloc.changeWalletSortings,
                items: [
                  Input$ParkingWalletSort(
                    field: Enum$ParkingWalletSortFields.balance,
                    direction: Enum$SortDirection.ASC,
                  ),
                  Input$ParkingWalletSort(
                    field: Enum$ParkingWalletSortFields.balance,
                    direction: Enum$SortDirection.DESC,
                  ),
                ],
                labelGetter: (sort) {
                  switch (sort.field) {
                    case Enum$ParkingWalletSortFields.balance:
                      return "${context.tr.walletBalance} (${sort.direction.titleAmount(context)})";
                    default:
                      return "";
                  }
                },
              ),
              getRowCount: (data) => data.parkingWallets.nodes.length,
              rowBuilder: (data, index) => _rowBuilder(
                context,
                data.parkingWallets.nodes[index],
                state.selectedCurrency ?? Env.defaultCurrency,
              ),
              getPageInfo: (data) => data.parkingWallets.pageInfo,
              data: state.walletListState,
              paging: state.walletPaging,
              onPageChanged: bloc.onPageChanged,
            );
          },
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$parkingWallets$parkingWallets$nodes data,
    String currency,
  ) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          ParkingAccountingDetailRoute(parkingId: data.customer.id),
        );
      },
      cells: [
        DataCell(
          Text(
            "#${data.customer.id}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(
          Row(
            children: [
              data.customer.media.widget(width: 40, height: 40),
              const SizedBox(width: 8),
              Text(
                data.customer.fullName,
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        DataCell(data.balance.toCurrency(context, currency)),
      ],
    );
  }
}
