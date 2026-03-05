import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/enums/taxi_support_request_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/graphql/taxi_support_request.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/presentation/blocs/taxi_support_request_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class TaxiSupportRequestListScreen extends StatefulWidget {
  const TaxiSupportRequestListScreen({super.key});

  @override
  State<TaxiSupportRequestListScreen> createState() =>
      _TaxiSupportRequestListScreenState();
}

class _TaxiSupportRequestListScreenState
    extends State<TaxiSupportRequestListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaxiSupportRequestBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.supportRequests,
              subtitle: context.tr.riderDriverComplaints,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  BlocBuilder<TaxiSupportRequestBloc, TaxiSupportRequestState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
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
                            DataColumn2(label: Text(context.tr.status)),
                            DataColumn2(
                              label: Text(context.tr.assignedTo),
                              size: ColumnSize.M,
                            ),
                          ],
                          sortOptions:
                              AppSortDropdown<Input$TaxiSupportRequestSort>(
                                selectedValues: state.sortFields,
                                onChanged: context
                                    .read<TaxiSupportRequestBloc>()
                                    .onSortingChanged,
                                items: [
                                  Input$TaxiSupportRequestSort(
                                    field: Enum$TaxiSupportRequestSortFields.id,
                                    direction: Enum$SortDirection.ASC,
                                  ),
                                  Input$TaxiSupportRequestSort(
                                    field: Enum$TaxiSupportRequestSortFields.id,
                                    direction: Enum$SortDirection.DESC,
                                  ),
                                  Input$TaxiSupportRequestSort(
                                    field: Enum$TaxiSupportRequestSortFields
                                        .status,
                                    direction: Enum$SortDirection.ASC,
                                  ),
                                  Input$TaxiSupportRequestSort(
                                    field: Enum$TaxiSupportRequestSortFields
                                        .status,
                                    direction: Enum$SortDirection.DESC,
                                  ),
                                ],
                                labelGetter: (sort) =>
                                    sort.field.tableViewSortLabel(
                                      context,
                                      sort.direction,
                                    ),
                              ),
                          filterOptions: [
                            AppFilterDropdown<Enum$ComplaintStatus>(
                              title: context.tr.status,
                              selectedValues: state.filterStatus,
                              onChanged: context
                                  .read<TaxiSupportRequestBloc>()
                                  .onFilterChanged,
                              items: Enum$ComplaintStatus.values.toFilterItems(
                                context,
                              ),
                            ),
                          ],
                          getRowCount: (data) =>
                              data.taxiSupportRequests.nodes.length,
                          rowBuilder: (data, index) =>
                              rowBuilder(data, index, context),
                          getPageInfo: (data) =>
                              data.taxiSupportRequests.pageInfo,
                          data: state.supportRequest,
                          paging: state.paging,
                          onPageChanged: context
                              .read<TaxiSupportRequestBloc>()
                              .onPageChanged,
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow rowBuilder(
    Query$taxiSupportRequests data,
    int index,
    BuildContext context,
  ) {
    final supportRequest = data.taxiSupportRequests.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          TaxiSupportRequestDetailRoute(id: supportRequest.id),
        );
      },
      cells: [
        DataCell(
          Text(
            supportRequest.subject,
            style: context.textTheme.labelMedium?.apply(
              color: context.colors.onSurface,
            ),
          ),
        ),
        DataCell(
          Text(
            supportRequest.inscriptionTimestamp.formatDateTime,
            style: context.textTheme.labelMedium?.apply(
              color: context.colors.onSurface,
            ),
          ),
        ),
        DataCell(
          Text(
            supportRequest.senderTitle(context),
            style: context.textTheme.labelMedium?.apply(
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
          _ => Row(
            children: [
              supportRequest.assignedToStaffs
                  .map((staff) => staff.media)
                  .toList()
                  .avatarsView(
                    context: context,
                    size: AvatarGroupSize.medium,
                    totalCount: supportRequest.assignedToStaffs.length,
                  ),
            ],
          ),
        }),
      ],
    );
  }
}
