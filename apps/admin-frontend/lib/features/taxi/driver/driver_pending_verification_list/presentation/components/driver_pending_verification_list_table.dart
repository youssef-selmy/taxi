import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/driver_sort_field.dart';
import 'package:admin_frontend/core/enums/driver_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/graphql/driver_pending_verification_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/presentation/blocs/driver_pending_verification_list.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverPendingVerificationListTable extends StatelessWidget {
  const DriverPendingVerificationListTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DriverPendingVerificationListBloc,
      DriverPendingVerificationListState
    >(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: AppDataTable(
            searchBarOptions: TableSearchBarOptions(
              onChanged: context
                  .read<DriverPendingVerificationListBloc>()
                  .onSearchQueryChanged,
            ),
            columns: [
              DataColumn2(label: Text(context.tr.name)),
              DataColumn2(
                label: Text(context.tr.mobileNumber),
                size: ColumnSize.L,
              ),
              DataColumn2(label: Text(context.tr.status), size: ColumnSize.L),
              const DataColumn2(label: Text(''), size: ColumnSize.L),
            ],
            sortOptions: AppSortDropdown(
              selectedValues: context
                  .read<DriverPendingVerificationListBloc>()
                  .state
                  .sorting,
              onChanged: (value) {
                context
                    .read<DriverPendingVerificationListBloc>()
                    .onSortingChanged(value);
              },
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
                  field: Enum$DriverSortFields.fleetId,
                  direction: Enum$SortDirection.ASC,
                ),
                Input$DriverSort(
                  field: Enum$DriverSortFields.fleetId,
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
              labelGetter: (item) =>
                  item.field.tableViewSortLabel(context, item.direction),
            ),
            filterOptions: [
              AppFilterDropdown<Enum$DriverStatus>(
                title: context.tr.status,
                selectedValues: state.driverStatusFilter,
                onChanged: context
                    .read<DriverPendingVerificationListBloc>()
                    .onStatusFilterChanged,
                items:
                    [
                          Enum$DriverStatus.PendingApproval,
                          Enum$DriverStatus.HardReject,
                          Enum$DriverStatus.SoftReject,
                        ]
                        .map(
                          (status) => FilterItem(
                            label: status.title(context),
                            value: status,
                          ),
                        )
                        .toList(),
              ),
            ],
            getRowCount: (data) => data.drivers.nodes.length,
            rowBuilder: (data, int index) => rowBuilder(context, data, index),
            getPageInfo: (data) => data.drivers.pageInfo,
            data: state.driversState,
            paging: state.paging,
            onPageChanged: context
                .read<DriverPendingVerificationListBloc>()
                .onPageChanged,
          ),
        );
      },
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$drivers data, int index) {
  final driver = data.drivers.nodes[index];
  return DataRow(
    cells: [
      DataCell(driver.tableView(context)),
      DataCell(
        AppLinkButton(
          text: driver.mobileNumber.formatPhoneNumber(null),
          onPressed: () {
            launchUrlString("tel:+${driver.mobileNumber}");
          },
        ),
      ),
      DataCell(driver.status.chip(context)),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppFilledButton(
              size: ButtonSize.medium,
              text: context.tr.verify,
              onPressed: () async {
                await context.router.push(
                  DriverPendingVerificationReviewRoute(driverId: driver.id),
                );
                context.read<DriverPendingVerificationListBloc>().onStarted();
              },
            ),
          ],
        ),
      ),
    ],
  );
}
