import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/enums/shop_support_request_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/customer_complaints_shop.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerComplaintsShop extends StatelessWidget {
  final String customerId;

  const CustomerComplaintsShop({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerComplaintsShopCubit()..onStarted(customerId: customerId),
      child:
          BlocBuilder<CustomerComplaintsShopCubit, CustomerComplaintsShopState>(
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
                        .read<CustomerComplaintsShopCubit>()
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
                        field: Enum$ShopSupportRequestSortFields.status,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$ShopSupportRequestSort(
                        field: Enum$ShopSupportRequestSortFields.status,
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
                          .read<CustomerComplaintsShopCubit>()
                          .onStatusFilterChanged,
                      items: Enum$ComplaintStatus.values.toFilterItems(context),
                    ),
                  ],
                  getRowCount: (data) => data.shopSupportRequests.nodes.length,
                  rowBuilder: (data, index) => _rowBuilder(
                    context,
                    data.shopSupportRequests.nodes[index],
                  ),
                  getPageInfo: (data) => data.shopSupportRequests.pageInfo,
                  data: state.complaintsResponse,
                  paging: state.paging,
                  onPageChanged: context
                      .read<CustomerComplaintsShopCubit>()
                      .onPageChanged,
                ),
              );
            },
          ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$shopSupportRequest node) {
    return DataRow(
      onSelectChanged: (value) {
        context.navigateTo(
          ShopShellRoute(
            children: [
              ShopSupportRequestShellRoute(
                children: [ShopSupportRequestDetailRoute(id: node.id)],
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
