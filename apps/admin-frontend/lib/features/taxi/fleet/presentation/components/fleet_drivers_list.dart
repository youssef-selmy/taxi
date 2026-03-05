import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/driver_sort_field.dart';
import 'package:admin_frontend/core/enums/driver_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_drivers.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_drivers.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class FleetDriverList extends StatefulWidget {
  const FleetDriverList({super.key});

  @override
  State<FleetDriverList> createState() => _FleetDriverListState();
}

class _FleetDriverListState extends State<FleetDriverList> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FleetDriversBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(context.tr.ordersList, style: context.textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<FleetDriversBloc, FleetDriversState>(
            builder: (context, state) {
              return AppDataTable(
                actions: _tableActionButtons(context),
                searchBarOptions: TableSearchBarOptions(
                  onChanged: bloc.onQueryChanged,
                ),
                columns: [
                  DataColumn(label: Text(context.tr.name)),
                  DataColumn2(
                    label: Text(context.tr.phoneNumber),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(context.tr.totalIncome),
                    size: ColumnSize.S,
                  ),
                  DataColumn(label: Text(context.tr.totalOrder)),
                  DataColumn(label: Text(context.tr.registerDate)),
                  DataColumn2(
                    label: Text(context.tr.status),
                    size: ColumnSize.S,
                  ),
                ],
                sortOptions: AppSortDropdown<Input$DriverSort>(
                  selectedValues: state.sortFields,
                  onChanged: bloc.onSortingChanged,
                  items: [
                    Input$DriverSort(
                      field: Enum$DriverSortFields.id,
                      direction: Enum$SortDirection.ASC,
                    ),
                    Input$DriverSort(
                      field: Enum$DriverSortFields.id,
                      direction: Enum$SortDirection.DESC,
                    ),
                    Input$DriverSort(
                      field: Enum$DriverSortFields.status,
                      direction: Enum$SortDirection.ASC,
                    ),
                    Input$DriverSort(
                      field: Enum$DriverSortFields.status,
                      direction: Enum$SortDirection.DESC,
                    ),
                    Input$DriverSort(
                      field: Enum$DriverSortFields.lastName,
                      direction: Enum$SortDirection.ASC,
                    ),
                    Input$DriverSort(
                      field: Enum$DriverSortFields.lastName,
                      direction: Enum$SortDirection.DESC,
                    ),
                  ],
                  labelGetter: (sort) =>
                      sort.field.tableViewSortLabel(context, sort.direction),
                ),
                filterOptions: [
                  AppFilterDropdown<Enum$DriverStatus>(
                    title: context.tr.status,
                    selectedValues: state.driverStatusFilter,
                    onChanged: bloc.onStatusChanged,
                    items: Enum$DriverStatus.values
                        .where((e) => e != Enum$DriverStatus.$unknown)
                        .map(
                          (status) =>
                              FilterItem(label: status.name, value: status),
                        )
                        .toList(),
                  ),
                ],
                getRowCount: (data) => data.drivers.nodes.length,
                rowBuilder: rowBuilder,
                getPageInfo: (data) => data.drivers.pageInfo,
                data: state.fleetDrivers,
                paging: state.paging,
                onPageChanged: bloc.onPageChanged,
              );
            },
          ),
        ),
      ],
    );
  }

  DataRow rowBuilder(Query$fleetDrivers data, int index) {
    final driver = data.drivers.nodes[index];
    return DataRow(
      onSelectChanged: (value) async {
        final bloc = context.read<FleetDriversBloc>();
        context.navigateTo(
          DriverShellRoute(children: [DriverDetailRoute(driverId: driver.id)]),
        );
        bloc.refresh();
      },
      cells: [
        DataCell(driver.tableView(context)),
        DataCell(
          AppLinkButton(
            text: driver.mobileNumber.formatPhoneNumber(null),
            onPressed: () {
              launchUrlString('tel:+${driver.mobileNumber}');
            },
          ),
        ),
        DataCell(driver.balanceText(context)),
        DataCell(Text('${driver.orders.totalCount} ${context.tr.orders}')),
        DataCell(
          Text(
            driver.registrationTimestamp.formatDateTime,
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(driver.status.chip(context)),
      ],
    );
  }
}

List<Widget> _tableActionButtons(BuildContext context) => [
  AppOutlinedButton(
    onPressed: () {
      // TODO : Implement add driver functionality
    },
    prefixIcon: BetterIcons.addCircleOutline,
    text: context.tr.add,
  ),
];
