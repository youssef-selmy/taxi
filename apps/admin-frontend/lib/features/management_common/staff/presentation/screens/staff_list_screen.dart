import 'package:admin_frontend/core/graphql/fragments/staff.graphql.extensions.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_list.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: context.tr.staff,
              subtitle: context.tr.staffListSubtitle,
              actions: [
                AppOutlinedButton(
                  onPressed: () {
                    context.router.push(const StaffRoleListRoute());
                  },
                  prefixIcon: Icons.toc_outlined,
                  text: context.tr.staffRoles,
                  color: SemanticColor.neutral,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<StaffListBloc, StaffListState>(
                builder: (context, state) {
                  return SafeArea(
                    top: false,
                    child: AppDataTable(
                      data: state.staffList,
                      searchBarOptions: TableSearchBarOptions(
                        onChanged: (query) =>
                            context.read<StaffListBloc>().onQueryChanged(query),
                      ),
                      actions: _tableActionButtons(context),
                      getPageInfo: (Query$staffs data) => data.staffs.pageInfo,
                      getRowCount: (Query$staffs data) =>
                          data.staffs.nodes.length,
                      columns: _tableColumnHeaders(context, state),
                      filterOptions: [
                        _buildRoleFilter(context, state.listFilterRole ?? []),
                        _buildStatusFilter(context, state),
                      ],
                      sortOptions: _tableSortOptions(context, state),
                      onPageChanged: context
                          .read<StaffListBloc>()
                          .onPageChanged,
                      paging: state.paging,
                      rowBuilder: (data, index) =>
                          _rowBuilder(context, data, index),
                    ),
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
}

AppFilterDropdown _buildStatusFilter(
  BuildContext context,
  StaffListState state,
) {
  return AppFilterDropdown<bool>(
    onChanged: (selectedItems) => context
        .read<StaffListBloc>()
        .onFilterCustomerStatusChanged(selectedItems),
    // selectedValues: state.filterCustomerStatus,
    title: context.tr.status,
    items: [
      FilterItem(label: context.tr.active, value: true),
      FilterItem(label: context.tr.inactive, value: false),
    ],
  );
}

AppFilterDropdown<Fragment$staffRole> _buildRoleFilter(
  BuildContext context,
  List<FilterItem<Fragment$staffRole>> listFilterRole,
) {
  return AppFilterDropdown<Fragment$staffRole>(
    onChanged: (selectedItems) =>
        context.read<StaffListBloc>().onFilterStaffRoleChanged(selectedItems),
    title: context.tr.role,
    items: listFilterRole,
  );
}

DataRow _rowBuilder(BuildContext context, Query$staffs data, int index) {
  final staff = data.staffs.nodes[index];
  return DataRow(
    cells: [
      DataCell(
        AppProfileCell(
          name: staff.fullName,
          imageUrl: staff.media?.address,
          subtitle: staff.isBlocked ? context.tr.blocked : null,
          subtitleColor: staff.isBlocked ? SemanticColor.error : null,
        ),
      ),
      DataCell(
        AppTag(
          prefixIcon: BetterIcons.clock01Filled,
          text: staff.lastActivity?.toTimeAgo ?? context.tr.never,
          color: SemanticColor.neutral,
        ),
      ),
      DataCell(Row(children: [Text(staff.role?.title ?? '')])),
      DataCell(Text(staff.userName)),
      DataCell(
        AppLinkButton(
          text: staff.mobileNumber?.formatPhoneNumber(null) ?? '',
          onPressed: () {
            launchUrlString('tel:+${staff.mobileNumber}');
          },
        ),
      ),
    ],
    onSelectChanged: (_) async {
      await context.router.push(StaffDetailRoute(id: staff.id));
      // ignore: use_build_context_synchronously
      context.read<StaffListBloc>().onStarted();
    },
  );
}

List<DataColumn> _tableColumnHeaders(
  BuildContext context,
  StaffListState state,
) {
  return [
    DataColumn(label: Text(context.tr.name)),
    DataColumn(label: Text(context.tr.lastActivityAt)),
    DataColumn2(label: Text(context.tr.role), size: ColumnSize.S),
    DataColumn(label: Text(context.tr.userName)),
    DataColumn(label: Text(context.tr.mobileNumber)),
  ];
}

List<Widget> _tableActionButtons(BuildContext context) {
  return [
    AppOutlinedButton(
      onPressed: () async {
        await context.router.push(NewStaffRoute());
        // ignore: use_build_context_synchronously
        context.read<StaffListBloc>().onStarted();
      },
      prefixIcon: BetterIcons.addCircleOutline,
      text: context.tr.newStaff,
    ),
  ];
}

AppSortDropdown<Input$OperatorSort> _tableSortOptions(
  BuildContext context,
  StaffListState state,
) {
  return AppSortDropdown<Input$OperatorSort>(
    onChanged: (p0) => context.read<StaffListBloc>().onSortFieldsChanged(p0),
    labelGetter: (item) {
      switch (item.field) {
        case Enum$OperatorSortFields.id:
          return "${context.tr.id} ${item.direction.titleNumber(context)}";
        case Enum$OperatorSortFields.isBlocked:
          return "${context.tr.status} ${item.direction.titleText(context)}";
        case Enum$OperatorSortFields.roleId:
          return "${context.tr.role} ${item.direction.titleNumber(context)}";
        default:
          return context.tr.unsupportedField;
      }
    },
    // selectedValues: state.sortFields,
    items: [
      Input$OperatorSort(
        field: Enum$OperatorSortFields.id,
        direction: Enum$SortDirection.ASC,
      ),
      Input$OperatorSort(
        field: Enum$OperatorSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
      Input$OperatorSort(
        field: Enum$OperatorSortFields.isBlocked,
        direction: Enum$SortDirection.ASC,
      ),
      Input$OperatorSort(
        field: Enum$OperatorSortFields.roleId,
        direction: Enum$SortDirection.ASC,
      ),
      Input$OperatorSort(
        field: Enum$OperatorSortFields.roleId,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );
}
