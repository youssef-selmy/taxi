import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/data/graphql/driver_accounting_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_accounting/driver_accounting_list/presentation/blocs/driver_accounting_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverAccountingListWalletsTable extends StatelessWidget {
  const DriverAccountingListWalletsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverAccountingListBloc>();
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previousState, currentState) =>
          previousState.supportedCurrencies !=
          previousState.supportedCurrencies,
      builder: (context, stateAuth) {
        return BlocBuilder<DriverAccountingListBloc, DriverAccountingListState>(
          builder: (context, state) {
            return AppDataTable(
              columns: [
                DataColumn2(label: Text(context.tr.id), fixedWidth: 60),
                DataColumn(label: Text(context.tr.driver)),
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
                  Input$DriverWalletSort(
                    field: Enum$DriverWalletSortFields.balance,
                    direction: Enum$SortDirection.ASC,
                  ),
                  Input$DriverWalletSort(
                    field: Enum$DriverWalletSortFields.balance,
                    direction: Enum$SortDirection.DESC,
                  ),
                ],
                labelGetter: (sort) {
                  switch (sort.field) {
                    case Enum$DriverWalletSortFields.balance:
                      return "${context.tr.walletBalance} (${sort.direction.titleAmount(context)})";
                    default:
                      return "";
                  }
                },
              ),
              getRowCount: (data) => data.driverWallets.nodes.length,
              rowBuilder: (data, index) => _rowBuilder(
                context,
                data.driverWallets.nodes[index],
                state.selectedCurrency ?? Env.defaultCurrency,
              ),
              getPageInfo: (data) => data.driverWallets.pageInfo,
              data: state.walletListState,
              onPageChanged: bloc.onPageChanged,
              paging: state.walletPaging,
            );
          },
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$driverWallets$driverWallets$nodes data,
    String currency,
  ) {
    return DataRow(
      onSelectChanged: data.driver == null
          ? null
          : (value) {
              context.router.push(
                DriverAccountingDetailRoute(driverId: data.driver!.id),
              );
            },
      cells: [
        DataCell(
          Text(
            "#${data.driver?.id ?? "-"}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(
          data.driver == null
              ? Text(context.tr.unknownDriver)
              : Row(
                  children: [
                    data.driver!.media.widget(width: 40, height: 40),
                    const SizedBox(width: 8),
                    Text(
                      data.driver!.fullName,
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
