import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/enums/shop_support_request_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_list/data/graphql/shop_support_request.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_list/presentation/blocs/shop_support_request_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ShopSupportRequestListScreen extends StatelessWidget {
  const ShopSupportRequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSupportRequestBloc()..onStarted(),
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
            Expanded(
              child:
                  BlocBuilder<ShopSupportRequestBloc, ShopSupportRequestState>(
                    builder: (context, state) {
                      return AppDataTable(
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
                          DataColumn(label: Text(context.tr.assignedTo)),
                        ],
                        sortOptions:
                            AppSortDropdown<Input$ShopSupportRequestSort>(
                              selectedValues: state.sortFields,
                              onChanged: context
                                  .read<ShopSupportRequestBloc>()
                                  .onSortingChanged,
                              items: [
                                Input$ShopSupportRequestSort(
                                  field: Enum$ShopSupportRequestSortFields.id,
                                  direction: Enum$SortDirection.ASC,
                                ),
                                Input$ShopSupportRequestSort(
                                  field: Enum$ShopSupportRequestSortFields.id,
                                  direction: Enum$SortDirection.DESC,
                                ),
                                Input$ShopSupportRequestSort(
                                  field:
                                      Enum$ShopSupportRequestSortFields.status,
                                  direction: Enum$SortDirection.ASC,
                                ),
                                Input$ShopSupportRequestSort(
                                  field:
                                      Enum$ShopSupportRequestSortFields.status,
                                  direction: Enum$SortDirection.DESC,
                                ),
                              ],
                              labelGetter: (sort) => sort.field
                                  .tableViewSortLabel(context, sort.direction),
                            ),
                        filterOptions: [
                          AppFilterDropdown<Enum$ComplaintStatus>(
                            title: context.tr.status,
                            selectedValues: state.filterStatus,
                            onChanged: context
                                .read<ShopSupportRequestBloc>()
                                .onFilterChanged,
                            items: Enum$ComplaintStatus.values.toFilterItems(
                              context,
                            ),
                          ),
                        ],
                        getRowCount: (data) =>
                            data.shopSupportRequests.nodes.length,
                        rowBuilder:
                            (Query$shopSupportRequests data, int index) =>
                                rowBuilder(data, index, context),
                        getPageInfo: (data) =>
                            data.shopSupportRequests.pageInfo,
                        data: state.supportRequest,
                        paging: state.paging,
                        onPageChanged: context
                            .read<ShopSupportRequestBloc>()
                            .onPageChanged,
                      );
                    },
                  ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  DataRow rowBuilder(
    Query$shopSupportRequests data,
    int index,
    BuildContext context,
  ) {
    final supportRequest = data.shopSupportRequests.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          ShopSupportRequestDetailRoute(id: supportRequest.id),
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
