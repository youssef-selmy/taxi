import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/parking_order_sort_field.dart';
import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/platform_overview/data/graphql/platform_overview.graphql.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformOverviewParkingTable extends StatelessWidget {
  const PlatformOverviewParkingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
      builder: (context, state) {
        return AppDataTable(
          searchBarOptions: TableSearchBarOptions(enabled: false),
          columns: [
            DataColumn2(label: Text(context.tr.id), fixedWidth: 70),
            DataColumn2(label: Text(context.tr.customer), size: ColumnSize.L),
            DataColumn2(label: Text(context.tr.parking), size: ColumnSize.L),
            DataColumn2(label: Text(context.tr.status), size: ColumnSize.L),
            DataColumn(label: Text(context.tr.dateAndTime)),
          ],
          sortOptions: AppSortDropdown<Input$ParkOrderSort>(
            selectedValues: state.parkingSortFields,
            onChanged: (value) {
              context.read<PlatformOverviewCubit>().onParkingSortingChanged(
                value,
              );
            },
            items: [
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.id,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.id,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.status,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.status,
                direction: Enum$SortDirection.DESC,
              ),
            ],
            labelGetter: (item) =>
                item.field.tableViewSortLabel(context, item.direction),
          ),
          getRowCount: (data) => data.parkOrders.nodes.length,
          rowBuilder: (data, int index) => rowBuilder(context, data, index),
          getPageInfo: (data) => data.parkOrders.pageInfo,
          data: state.parkingOrders,
          paging: state.parkingOrdersPaging,
          onPageChanged: context
              .read<PlatformOverviewCubit>()
              .onParkingOrdersPageChanged,
        );
      },
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$parkingOrders data, int index) {
  final parking = data.parkOrders.nodes[index];
  return DataRow(
    onSelectChanged: (value) async {
      locator<AuthBloc>().add(AuthEvent.changeAppType(Enum$AppType.Parking));
      context.navigateTo(
        ParkingShellRoute(
          children: [
            ParkingOrderShellRoute(
              children: [ParkingOrderDetailRoute(parkingOrderId: parking.id)],
            ),
          ],
        ),
      );
    },
    cells: [
      DataCell(
        Text(
          '#${parking.id}',
          style: context.textTheme.labelMedium?.variant(context),
        ),
      ),
      DataCell(parking.carOwner?.tableView(context) ?? const SizedBox()),
      DataCell(parking.parkSpot.tableView(context)),
      DataCell(parking.status.toChip(context)),
      DataCell(
        Text(
          parking.createdAt.formatDateTime,
          style: context.textTheme.labelMedium,
        ),
      ),
    ],
  );
}
