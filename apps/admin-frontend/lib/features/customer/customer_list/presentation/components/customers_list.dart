import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomersList extends StatelessWidget {
  const CustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomersBloc>();
    return BlocBuilder<CustomersBloc, CustomersState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppDataTable(
              data: state.customers,
              searchBarOptions: TableSearchBarOptions(
                onChanged: bloc.onQueryChanged,
                hintText: context.tr.search,
                query: state.query,
              ),
              actions: _tableActionButtons(context),
              sortOptions: _tableSortOptions(context, state),
              getPageInfo: (data) => data.pageInfo,
              getRowCount: (data) => data.nodes.length,
              columns: _tableColumnHeaders(context, state),
              filterOptions: [_buildStatusFilter(context, state)],
              onPageChanged: bloc.onPageChanged,
              paging: state.paging,
              rowBuilder: (data, index) => _row(context, data, index),
            ),
          ),
        );
      },
    );
  }

  AppFilterDropdown<Enum$RiderStatus> _buildStatusFilter(
    BuildContext context,
    CustomersState state,
  ) {
    return AppFilterDropdown<Enum$RiderStatus>(
      onChanged: (selectedItems) => context
          .read<CustomersBloc>()
          .onFilterCustomerStatusChanged(selectedItems),
      selectedValues: state.filterCustomerStatus,
      title: context.tr.status,
      items: [
        FilterItem(label: context.tr.active, value: Enum$RiderStatus.Enabled),
        FilterItem(
          label: context.tr.inactive,
          value: Enum$RiderStatus.Disabled,
        ),
      ],
    );
  }

  List<Widget> _tableActionButtons(BuildContext context) {
    return [
      AppOutlinedButton(
        onPressed: () async {
          await context.router.push(const CreateCustomerRoute());
          context.read<CustomersBloc>().refreshCustomers();
        },
        prefixIcon: BetterIcons.addCircleOutline,
        text: context.tr.add,
      ),
    ];
  }

  DataRow _row(
    BuildContext context,
    Fragment$CustomersListConnection data,
    int index,
  ) {
    final e = data.nodes[index];
    return DataRow(
      onSelectChanged: (value) async {
        await context.router.push(CustomerDetailsRoute(customerId: e.id));
        context.read<CustomersBloc>().refreshCustomers();
      },
      cells: [
        DataCell(e.tableView(context)),
        DataCell(
          AppTag(
            prefixIcon: BetterIcons.clock01Filled,
            text: e.lastActivityAt?.toTimeAgo ?? context.tr.never,
            color: SemanticColor.neutral,
          ),
        ),
        DataCell(
          AppLinkButton(
            text: e.mobileNumber.formatPhoneNumber(e.countryIso),
            onPressed: () {
              launchUrlString('tel:+${e.mobileNumber}');
            },
          ),
        ),
        DataCell(e.balanceText(context)),
        DataCell(
          Text.rich(
            TextSpan(
              text: e.orderCount.firstOrNull?.count?.id.toString() ?? "0",
              style: context.textTheme.labelMedium,
              children: [
                TextSpan(
                  text: context.tr.orders,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<DataColumn> _tableColumnHeaders(
    BuildContext context,
    CustomersState state,
  ) {
    return [
      DataColumn(label: Text(context.tr.name)),
      DataColumn(label: Text(context.tr.lastActivityAt)),
      DataColumn(label: Text(context.tr.mobileNumber)),
      DataColumn(label: Text(context.tr.walletBalance)),
      DataColumn(label: Text(context.tr.totalOrders)),
    ];
  }

  AppSortDropdown<Input$RiderSort> _tableSortOptions(
    BuildContext context,
    CustomersState state,
  ) {
    return AppSortDropdown<Input$RiderSort>(
      onChanged: (p0) => context.read<CustomersBloc>().onSortFieldsChanged(p0),
      labelGetter: (item) {
        switch (item.field) {
          case Enum$RiderSortFields.id:
            return "${context.tr.id} ${item.direction.titleNumber(context)}";
          case Enum$RiderSortFields.firstName:
            return "${context.tr.firstName} ${item.direction.titleText(context)}";

          case Enum$RiderSortFields.lastName:
            return "${context.tr.lastName} ${item.direction.titleText(context)}";

          case Enum$RiderSortFields.status:
            return "${context.tr.status} ${item.direction.titleText(context)}";

          default:
            return "Unsuppored field";
        }
      },
      selectedValues: state.sortFields,
      items: [
        Input$RiderSort(
          field: Enum$RiderSortFields.id,
          direction: Enum$SortDirection.ASC,
        ),
        Input$RiderSort(
          field: Enum$RiderSortFields.id,
          direction: Enum$SortDirection.DESC,
        ),
        Input$RiderSort(
          field: Enum$RiderSortFields.firstName,
          direction: Enum$SortDirection.ASC,
        ),
        Input$RiderSort(
          field: Enum$RiderSortFields.firstName,
          direction: Enum$SortDirection.DESC,
        ),
        Input$RiderSort(
          field: Enum$RiderSortFields.lastName,
          direction: Enum$SortDirection.ASC,
        ),
        Input$RiderSort(
          field: Enum$RiderSortFields.lastName,
          direction: Enum$SortDirection.DESC,
        ),
      ],
    );
  }
}
