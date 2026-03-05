import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/enums/driver_sort_field.dart';
import 'package:admin_frontend/core/enums/driver_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverListTable extends StatelessWidget {
  const DriverListTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverListBloc()..onStarted(),
      child: BlocBuilder<DriverListBloc, DriverListState>(
        builder: (context, state) {
          return Padding(
            padding: context.pagePaddingHorizontal.copyWith(
              bottom: 16,
              top: 16,
            ),
            child: AppDataTable(
              searchBarOptions: TableSearchBarOptions(
                onChanged: context.read<DriverListBloc>().onSearchQueryChanged,
              ),
              minWidth: 1000,
              columns: [
                DataColumn2(label: Text(context.tr.name), size: ColumnSize.L),
                DataColumn2(
                  label: Text(context.tr.mobileNumber),
                  size: ColumnSize.M,
                ),
                DataColumn2(label: Text(context.tr.rating), size: ColumnSize.S),
                DataColumn(label: Text(context.tr.status)),
                DataColumn(label: Text(context.tr.walletBalance)),
                DataColumn2(
                  label: Text(context.tr.totalOrders),
                  size: ColumnSize.S,
                ),
              ],
              sortOptions: AppSortDropdown(
                selectedValues: context.read<DriverListBloc>().state.sorting,
                onChanged: (value) {
                  context.read<DriverListBloc>().onSortingChanged(value);
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
                      .read<DriverListBloc>()
                      .onStatusFilterChanged,
                  items: Enum$DriverStatus.values.toFilterItems(context),
                ),
              ],
              getRowCount: (data) => data.drivers.nodes.length,
              rowBuilder: (data, int index) => rowBuilder(context, data, index),
              getPageInfo: (data) => data.drivers.pageInfo,
              data: state.driversState,
              paging: state.paging,
              onPageChanged: context.read<DriverListBloc>().onPageChanged,
              actions: _tableActionButtons(context),
            ),
          );
        },
      ),
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$drivers data, int index) {
  final driver = data.drivers.nodes[index];
  final bloc = context.read<DriverListBloc>();
  return DataRow(
    onSelectChanged: (value) async {
      await context.router.push(DriverDetailRoute(driverId: driver.id));
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
      DataCell(RatingIndicator(rating: driver.rating?.toInt())),
      DataCell(
        AppDropdownStatus(
          initialValue: driver.status,
          items: Enum$DriverStatus.values.toDropDownStatusItems(context),
          onChanged: (value) {
            context.read<DriverListBloc>().onDriverStatusChanged(
              driver.id,
              value!,
            );
          },
        ),
      ),
      DataCell(driver.balanceText(context)),
      DataCell(
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${driver.orders.totalCount}',
                style: context.textTheme.labelMedium,
              ),
              TextSpan(
                text: ' ${context.tr.orders}',
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

List<Widget> _tableActionButtons(BuildContext context) {
  return [
    AppOutlinedButton(
      onPressed: () async {
        await context.router.push(CreateNewDriverRoute());
        context.read<DriverListBloc>().refresh();
      },
      prefixIcon: BetterIcons.addCircleOutline,
      text: context.tr.add,
    ),
  ];
}
