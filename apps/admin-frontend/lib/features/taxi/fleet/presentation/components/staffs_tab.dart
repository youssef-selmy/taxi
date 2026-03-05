import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_staffs.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_staffs.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class FleetStaffsTab extends StatelessWidget {
  const FleetStaffsTab({super.key, required this.fleetId});

  final String fleetId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetStaffsBloc()..onStarted(fleetId),
      child: Container(
        color: context.colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(title: context.tr.staff),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<FleetStaffsBloc, FleetStaffsState>(
                builder: (context, state) {
                  return AppDataTable(
                    data: state.fleetStaffs,
                    searchBarOptions: TableSearchBarOptions(
                      onChanged: (query) =>
                          context.read<FleetStaffsBloc>().onQueryChanged(query),
                    ),
                    actions: _tableActionButtons(context, fleetId),
                    getPageInfo: (data) => data.fleetStaffs.pageInfo,
                    getRowCount: (data) => data.fleetStaffs.nodes.length,
                    columns: _tableColumnHeaders(context),
                    filterOptions: [_buildStatusFilter(context, state)],
                    sortOptions: _tableSortOptions(context, state),
                    paging: state.paging,
                    onPageChanged: context
                        .read<FleetStaffsBloc>()
                        .onPageChanged,
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data, index),
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

AppFilterDropdown<bool> _buildStatusFilter(
  BuildContext context,
  FleetStaffsState state,
) {
  return AppFilterDropdown<bool>(
    onChanged: (selectedItems) =>
        context.read<FleetStaffsBloc>().onFilterStatusChanged(selectedItems),
    selectedValues: state.statusFilter,
    title: context.tr.status,
    items: [
      FilterItem(label: context.tr.active, value: true),
      FilterItem(label: context.tr.inactive, value: false),
    ],
  );
}

DataRow _rowBuilder(
  BuildContext context,
  Query$fleetStaffList data,
  int index,
) {
  final staff = data.fleetStaffs.nodes[index];
  return DataRow(
    cells: [
      DataCell(
        AppProfileCell(
          name: "${staff.firstName} ${staff.lastName}",
          imageUrl: staff.profileImage?.address,
          statusBadgeType: staff.isBlocked
              ? StatusBadgeType.busy
              : StatusBadgeType.none,
          subtitle: staff.isBlocked ? context.tr.blocked : null,
          subtitleColor: staff.isBlocked ? SemanticColor.error : null,
        ),
      ),
      DataCell(
        AppTag(
          prefixIcon: BetterIcons.clock01Filled,
          text: staff.lastActivityAt?.toTimeAgo ?? context.tr.never,
          color: SemanticColor.neutral,
        ),
      ),
      DataCell(Row(children: [Text(staff.userName)])),
      DataCell(
        AppLinkButton(
          text: staff.mobileNumber.formatPhoneNumber(null),
          onPressed: () {
            launchUrl(Uri.parse('tell://${staff.mobileNumber}'));
          },
        ),
      ),
      DataCell(Text(staff.email ?? "-")),
    ],
    onSelectChanged: (_) {
      context.router.push(FleetStaffDetailRoute(id: staff.id));
    },
  );
}

List<DataColumn> _tableColumnHeaders(BuildContext context) {
  return [
    DataColumn(label: Text(context.tr.name)),
    DataColumn(label: Text(context.tr.lastActivityAt)),
    DataColumn(label: Text(context.tr.userName)),
    DataColumn(label: Text(context.tr.mobileNumber)),
    DataColumn(label: Text(context.tr.email)),
  ];
}

List<Widget> _tableActionButtons(BuildContext context, String fleetID) {
  return [
    AppOutlinedButton(
      onPressed: () {
        context.router.push(AddFleetStaffRoute(fleetID: fleetID));
      },
      prefixIcon: BetterIcons.addCircleOutline,
      text: context.tr.newStaff,
    ),
  ];
}

AppSortDropdown<Input$FleetStaffSort> _tableSortOptions(
  BuildContext context,
  FleetStaffsState state,
) {
  return AppSortDropdown<Input$FleetStaffSort>(
    onChanged: (p0) => context.read<FleetStaffsBloc>().onSortFieldsChanged(p0),
    labelGetter: (item) {
      switch (item.field) {
        case Enum$FleetStaffSortFields.id:
          return "${context.tr.id} ${item.direction.titleNumber(context)}";

        case Enum$FleetStaffSortFields.isBlocked:
          return "${context.tr.status} ${item.direction.titleText(context)}";

        default:
          return "Unsuppored field";
      }
    },
    selectedValues: state.sortFields,
    items: [
      Input$FleetStaffSort(
        field: Enum$FleetStaffSortFields.id,
        direction: Enum$SortDirection.ASC,
      ),
      Input$FleetStaffSort(
        field: Enum$FleetStaffSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
      Input$FleetStaffSort(
        field: Enum$FleetStaffSortFields.isBlocked,
        direction: Enum$SortDirection.ASC,
      ),
      Input$FleetStaffSort(
        field: Enum$FleetStaffSortFields.isBlocked,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );
}
