import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/enums/parking_support_request_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/customer_complaints_parking.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerComplaintsParking extends StatelessWidget {
  final String customerId;

  const CustomerComplaintsParking({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerComplaintsParkingCubit()..onStarted(customerId: customerId),
      child:
          BlocBuilder<
            CustomerComplaintsParkingCubit,
            CustomerComplaintsParkingState
          >(
            builder: (context, state) {
              return SafeArea(
                top: false,
                child: AppDataTable(
                  title: context.tr.supportRequests,
                  titleSize: TitleSize.small,
                  columns: [
                    DataColumn(label: Text(context.tr.title)),
                    DataColumn2(
                      label: Text(context.tr.dateAndTime),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(context.tr.comment),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(label: Text(context.tr.status)),
                  ],
                  sortOptions: AppSortDropdown(
                    selectedValues: state.sorting,
                    onChanged: context
                        .read<CustomerComplaintsParkingCubit>()
                        .onSortingChanged,
                    items: [
                      Input$ParkingSupportRequestSort(
                        field: Enum$ParkingSupportRequestSortFields.id,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$ParkingSupportRequestSort(
                        field: Enum$ParkingSupportRequestSortFields.id,
                        direction: Enum$SortDirection.DESC,
                      ),
                      Input$ParkingSupportRequestSort(
                        field: Enum$ParkingSupportRequestSortFields.status,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$ParkingSupportRequestSort(
                        field: Enum$ParkingSupportRequestSortFields.status,
                        direction: Enum$SortDirection.DESC,
                      ),
                    ],
                    labelGetter: (sort) =>
                        sort.field.tableViewSortLabel(context, sort.direction),
                  ),
                  filterOptions: [
                    AppFilterDropdown<Enum$ComplaintStatus>(
                      title: context.tr.status,
                      selectedValues: state.filterStatus,
                      onChanged: context
                          .read<CustomerComplaintsParkingCubit>()
                          .onStatusFilterChanged,
                      items: Enum$ComplaintStatus.values.toFilterItems(context),
                    ),
                  ],
                  getRowCount: (data) =>
                      data.parkingSupportRequests.nodes.length,
                  rowBuilder: (data, index) => _rowBuilder(
                    context,
                    data.parkingSupportRequests.nodes[index],
                  ),
                  getPageInfo: (data) => data.parkingSupportRequests.pageInfo,
                  data: state.complaintsResponse,
                  paging: state.paging,
                  onPageChanged: context
                      .read<CustomerComplaintsParkingCubit>()
                      .onPageChanged,
                ),
              );
            },
          ),
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$parkingSupportRequest node,
  ) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.navigate(
          ParkingShellRoute(
            children: [
              ParkingSupportRequestShellRoute(
                children: [ParkingSupportRequestDetailRoute(id: node.id)],
              ),
            ],
          ),
        );
      },
      cells: [
        DataCell(Text(node.subject, style: context.textTheme.labelMedium)),
        DataCell(
          Text(
            node.createdAt.formatDateTime,
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(
          Text(
            node.content ?? context.tr.notFound,
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.status.chip(context)),
      ],
    );
  }
}
