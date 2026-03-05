import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/enums/taxi_support_request_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/customer_complaints_taxi.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerComplaintsTaxi extends StatelessWidget {
  final String customerId;

  const CustomerComplaintsTaxi({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerComplaintsTaxiCubit()..onStarted(customerId: customerId),
      child:
          BlocBuilder<CustomerComplaintsTaxiCubit, CustomerComplaintsTaxiState>(
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
                    selectedValues: state.sortFields,
                    onChanged: context
                        .read<CustomerComplaintsTaxiCubit>()
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
                        field: Enum$TaxiSupportRequestSortFields.status,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$TaxiSupportRequestSort(
                        field: Enum$TaxiSupportRequestSortFields.status,
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
                          .read<CustomerComplaintsTaxiCubit>()
                          .onStatusFilterChanged,
                      items: Enum$ComplaintStatus.values.toFilterItems(context),
                    ),
                  ],
                  getRowCount: (data) => data.taxiSupportRequests.nodes.length,
                  rowBuilder: (data, index) => _rowBuilder(
                    context,
                    data.taxiSupportRequests.nodes[index],
                  ),
                  getPageInfo: (data) => data.taxiSupportRequests.pageInfo,
                  data: state.complaintsResponse,
                  paging: state.paging,
                  onPageChanged: context
                      .read<CustomerComplaintsTaxiCubit>()
                      .onPageChanged,
                ),
              );
            },
          ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$taxiSupportRequest node) {
    return DataRow(
      onSelectChanged: (value) {
        context.navigateTo(
          TaxiShellRoute(
            children: [
              TaxiSupportRequestShellRoute(
                children: [TaxiSupportRequestDetailRoute(id: node.id)],
              ),
            ],
          ),
        );
      },
      cells: [
        DataCell(Text(node.subject, style: context.textTheme.labelMedium)),
        DataCell(
          Text(
            node.inscriptionTimestamp.formatDateTime,
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
