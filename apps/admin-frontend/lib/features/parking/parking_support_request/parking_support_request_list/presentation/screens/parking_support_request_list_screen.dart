import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/enums/parking_support_request_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/graphql/parking_support_request.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/presentation/blocs/parking_support_request_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ParkingSupportRequestListScreen extends StatelessWidget {
  const ParkingSupportRequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingSupportRequestBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.supportRequests,
              subtitle: context.tr.riderDriverComplaints,
            ),
            const SizedBox(height: 16),
            BlocBuilder<ParkingSupportRequestBloc, ParkingSupportRequestState>(
              builder: (context, state) {
                return Expanded(
                  child: AppDataTable(
                    columns: [
                      DataColumn(label: Text(context.tr.title)),
                      DataColumn2(
                        label: Text(context.tr.dateAndTime),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text(context.tr.submittedBy),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text(context.tr.status),
                        size: ColumnSize.S,
                      ),
                      DataColumn(label: Text(context.tr.assignedTo)),
                    ],
                    sortOptions:
                        AppSortDropdown<Input$ParkingSupportRequestSort>(
                          selectedValues: state.sortFields,
                          onChanged: context
                              .read<ParkingSupportRequestBloc>()
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
                              field:
                                  Enum$ParkingSupportRequestSortFields.status,
                              direction: Enum$SortDirection.ASC,
                            ),
                            Input$ParkingSupportRequestSort(
                              field:
                                  Enum$ParkingSupportRequestSortFields.status,
                              direction: Enum$SortDirection.DESC,
                            ),
                          ],
                          labelGetter: (sort) => sort.field.tableViewSortLabel(
                            context,
                            sort.direction,
                          ),
                        ),
                    filterOptions: [
                      AppFilterDropdown<Enum$ComplaintStatus>(
                        title: context.tr.status,
                        selectedValues: state.filterStatus,
                        onChanged: context
                            .read<ParkingSupportRequestBloc>()
                            .onFilterChanged,
                        items: Enum$ComplaintStatus.values.toFilterItems(
                          context,
                        ),
                      ),
                    ],
                    getRowCount: (data) =>
                        data.parkingSupportRequests.nodes.length,
                    rowBuilder:
                        (Query$parkingSupportRequests data, int index) =>
                            rowBuilder(data, index, context),
                    getPageInfo: (data) => data.parkingSupportRequests.pageInfo,
                    data: state.supportRequest,
                    paging: state.paging,
                    onPageChanged: context
                        .read<ParkingSupportRequestBloc>()
                        .onPageChanged,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  DataRow rowBuilder(
    Query$parkingSupportRequests data,
    int index,
    BuildContext context,
  ) {
    final supportRequest = data.parkingSupportRequests.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          ParkingSupportRequestDetailRoute(id: supportRequest.id),
        );
      },
      cells: [
        DataCell(
          Text(
            supportRequest.subject,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ),
        DataCell(
          Text(
            supportRequest.createdAt.formatDateTime,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ),
        DataCell(
          Text(
            supportRequest.senderTitle(context),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ),
        DataCell(supportRequest.status.chip(context)),
        DataCell(switch (supportRequest.assignedToStaffs.length) {
          0 => Text(
            "-",
            style: context.textTheme.labelMedium?.variant(context),
          ),
          1 => supportRequest.assignedToStaffs.first.tableView(context),
          _ =>
            supportRequest.assignedToStaffs
                .map((staff) => staff.media)
                .toList()
                .avatarsView(context: context, size: AvatarGroupSize.medium),
        }),
      ],
    );
  }
}
