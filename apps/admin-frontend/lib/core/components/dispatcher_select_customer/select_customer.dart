import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/dispatcher_select_customer/bloc/customer_list.cubit.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_icons/better_icons.dart';

class SelectCustomer extends StatelessWidget {
  final Function(Fragment$CustomerCompact) onCustomerSelected;

  const SelectCustomer({super.key, required this.onCustomerSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerListCubit()..onStarted(),
      child: Padding(
        padding: context.pagePaddingHorizontal,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppOutlinedButton(
                  onPressed: () {
                    context.router.replaceAll([
                      DashboardRoute(),
                      CustomerShellRoute(),
                      CustomersRoute(),
                      CreateCustomerRoute(),
                    ]);
                  },
                  prefixIcon: BetterIcons.addCircleOutline,
                  text: context.tr.add,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CustomerListCubit, CustomerListState>(
                builder: (context, state) {
                  return AppDataTable(
                    data: state.customerList,
                    getPageInfo: (p0) => p0.riders.pageInfo,
                    getRowCount: (p0) => p0.riders.nodes.length,
                    onPageChanged: context
                        .read<CustomerListCubit>()
                        .onPageChanged,
                    paging: state.paging,
                    columns: [
                      DataColumn(label: Text(context.tr.name)),
                      DataColumn(label: Text(context.tr.lastActivityAt)),
                    ],
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data.riders.nodes[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$CustomerCompact data) {
    return DataRow(
      onSelectChanged: (value) {
        onCustomerSelected(data);
      },
      cells: [
        DataCell(data.tableView(context)),
        DataCell(
          AppTag(
            prefixIcon: BetterIcons.clock01Filled,
            text: data.lastActivityAt?.toTimeAgo ?? context.tr.never,
            color: SemanticColor.neutral,
          ),
        ),
      ],
    );
  }
}
