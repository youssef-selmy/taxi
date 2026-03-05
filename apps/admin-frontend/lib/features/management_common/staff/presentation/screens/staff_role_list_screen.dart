import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_list.cubit.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_role_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class StaffRoleListScreen extends StatelessWidget {
  const StaffRoleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffRoleListBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: context.tr.staffRoles,
              subtitle: context.tr.adminUserRoleDefinitions,
              showBackButton: true,
              onBackButtonPressed: () {
                context.router.replace(const StaffListRoute());
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<StaffRoleListBloc, StaffRoleListState>(
                builder: (context, state) {
                  return AppDataTable(
                    data: state.staffRoles,
                    searchBarOptions: TableSearchBarOptions(
                      onChanged: (query) =>
                          context.read<StaffListBloc>().onQueryChanged(query),
                    ),
                    actions: _tableActionButtons(context),
                    // sortOptions: _tableSortOptions(context, state),
                    getPageInfo: (Query$staffRoles data) =>
                        Fragment$OffsetPageInfo(),
                    getRowCount: (Query$staffRoles data) =>
                        data.staffRoles.length,
                    columns: _tableColumnHeaders(context, state),
                    paging: state.paging,
                    onPageChanged: context
                        .read<StaffRoleListBloc>()
                        .onPageChanged,
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data.staffRoles, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow _rowBuilder(
  BuildContext context,
  List<Fragment$staffRole> data,
  int index,
) {
  final staffRole = data[index];
  return DataRow(
    cells: [
      DataCell(Row(children: [Text(staffRole.title)])),
    ],
    onSelectChanged: (_) {
      context.router.push(StaffRoleDetailRoute(id: staffRole.id));
    },
  );
}

List<DataColumn> _tableColumnHeaders(
  BuildContext context,
  StaffRoleListState state,
) {
  return [DataColumn(label: Text(context.tr.name))];
}

List<Widget> _tableActionButtons(BuildContext context) {
  return [
    AppOutlinedButton(
      onPressed: () {
        context.router.push(StaffRoleDetailRoute(id: null));
      },
      prefixIcon: BetterIcons.addCircleOutline,
      text: context.tr.add,
    ),
  ];
}
