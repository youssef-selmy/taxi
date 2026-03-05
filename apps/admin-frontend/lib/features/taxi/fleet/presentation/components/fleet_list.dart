import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_list.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class FleetList extends StatelessWidget {
  const FleetList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FleetListBloc, FleetListState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: AppDataTable(
            actions: _tableActionButtons(context),
            data: state.fleets,
            searchBarOptions: TableSearchBarOptions(
              onChanged: (query) =>
                  context.read<FleetListBloc>().onQueryChanged(query),
            ),
            sortOptions: _tableSortOptions(context, state),
            getPageInfo: (data) => data.fleets.pageInfo,
            getRowCount: (data) => data.fleets.nodes.length,
            columns: _tableColumnHeaders(context, state),
            onPageChanged: context.read<FleetListBloc>().onPageChanged,
            paging: state.paging,
            rowBuilder: (data, index) => _row(context, data, index),
          ),
        );
      },
    );
  }
}

List<Widget> _tableActionButtons(BuildContext context) {
  return [
    AppOutlinedButton(
      onPressed: () async {
        await context.router.push(const AddFleetRoute());
        context.read<FleetListBloc>().onStarted();
      },
      prefixIcon: BetterIcons.addCircleOutline,
      text: context.tr.add,
    ),
  ];
}

DataRow _row(BuildContext context, Query$fleetsList data, int index) {
  final e = data.fleets.nodes[index];
  return DataRow(
    onSelectChanged: (value) async {
      await context.router.push(FleetAccountDetailRoute(fleetId: e.id));
      context.read<FleetListBloc>().onStarted();
    },
    cells: [
      DataCell(
        AppProfileCell(
          name: e.name,
          imageUrl: e.profilePicture?.address,
          statusBadgeType: e.isBlocked
              ? StatusBadgeType.away
              : StatusBadgeType.none,
          subtitle: e.isBlocked ? context.tr.blocked : null,
        ),
      ),
      DataCell(
        AppLinkButton(
          text: e.mobileNumber.formatPhoneNumber(null),
          onPressed: () {
            launchUrl(Uri.parse('tell://${e.mobileNumber}'));
          },
        ),
      ),
      DataCell(
        Text.rich(
          TextSpan(
            text: e.driversAggregate.firstOrNull?.count?.id.toString() ?? '0',
            style: context.textTheme.labelMedium,
            children: [
              TextSpan(
                text: " ${context.tr.drivers}",
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        ),
      ),
      DataCell(
        e.wallet
            .map((e) => e.balance.toCurrency(context, e.currency))
            .toList()
            .wrapWithCommas(),
      ),
    ],
  );
}

List<DataColumn> _tableColumnHeaders(
  BuildContext context,
  FleetListState state,
) {
  return [
    DataColumn(label: Text(context.tr.name)),
    DataColumn(label: Text(context.tr.mobileNumber)),
    DataColumn(label: Text(context.tr.driver)),
    DataColumn(label: Text(context.tr.wallet)),
  ];
}

AppSortDropdown<Input$FleetSort> _tableSortOptions(
  BuildContext context,
  FleetListState state,
) {
  return AppSortDropdown<Input$FleetSort>(
    onChanged: (p0) => context.read<FleetListBloc>().onSortFieldsChanged(p0),
    labelGetter: (item) {
      switch (item.field) {
        case Enum$FleetSortFields.id:
          return "${context.tr.id} ${item.direction.titleNumber(context)}";
        case Enum$FleetSortFields.name:
          return "${context.tr.firstName} ${item.direction.titleText(context)}";

        default:
          return "Unsuppored field";
      }
    },
    selectedValues: state.sortFields,
    items: [
      Input$FleetSort(
        field: Enum$FleetSortFields.id,
        direction: Enum$SortDirection.ASC,
      ),
      Input$FleetSort(
        field: Enum$FleetSortFields.id,
        direction: Enum$SortDirection.DESC,
      ),
      Input$FleetSort(
        field: Enum$FleetSortFields.name,
        direction: Enum$SortDirection.ASC,
      ),
      Input$FleetSort(
        field: Enum$FleetSortFields.name,
        direction: Enum$SortDirection.DESC,
      ),
    ],
  );
}
