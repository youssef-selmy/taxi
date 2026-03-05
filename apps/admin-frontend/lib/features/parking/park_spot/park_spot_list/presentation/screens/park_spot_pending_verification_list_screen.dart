import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/park_spot_sort_fields.dart';
import 'package:admin_frontend/core/enums/park_spot_status.dart';
import 'package:admin_frontend/core/enums/park_spot_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/presentation/blocs/park_spot_pending_verification_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ParkSpotPendingVerificationListScreen extends StatelessWidget {
  const ParkSpotPendingVerificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkSpotPendingVerificationListBloc()..onStarted(),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: context.tr.pendingVerificationParkings,
              subtitle: context.tr.pendingReviewParkingSpotsList,
            ),
            const SizedBox(height: 24),
            BlocBuilder<
              ParkSpotPendingVerificationListBloc,
              ParkSpotPendingVerificationListState
            >(
              builder: (context, state) {
                return Expanded(
                  child: AppDataTable(
                    searchBarOptions: TableSearchBarOptions(
                      enabled: true,
                      onChanged: context
                          .read<ParkSpotPendingVerificationListBloc>()
                          .onSearchQueryChanged,
                      query: state.searchQuery,
                    ),
                    sortOptions: AppSortDropdown<Input$ParkSpotSort>(
                      onChanged: context
                          .read<ParkSpotPendingVerificationListBloc>()
                          .onSortChanged,
                      selectedValues: state.sorting,
                      items: [
                        Input$ParkSpotSort(
                          field: Enum$ParkSpotSortFields.id,
                          direction: Enum$SortDirection.ASC,
                        ),
                        Input$ParkSpotSort(
                          field: Enum$ParkSpotSortFields.id,
                          direction: Enum$SortDirection.DESC,
                        ),
                        Input$ParkSpotSort(
                          field: Enum$ParkSpotSortFields.ratingAggregate,
                          direction: Enum$SortDirection.ASC,
                        ),
                        Input$ParkSpotSort(
                          field: Enum$ParkSpotSortFields.ratingAggregate,
                          direction: Enum$SortDirection.DESC,
                        ),
                      ],
                      labelGetter: (input) => input.field.tableViewSortLabel(
                        context,
                        input.direction,
                      ),
                    ),
                    filterOptions: [
                      AppFilterDropdown<Enum$ParkSpotStatus>(
                        title: context.tr.status,
                        selectedValues: state.statusFilter,
                        onChanged: context
                            .read<ParkSpotPendingVerificationListBloc>()
                            .onStatusFilterChanged,
                        items: Enum$ParkSpotStatus.values.toFilterItems(
                          context,
                        ),
                      ),
                      AppFilterDropdown<Enum$ParkSpotType>(
                        title: context.tr.type,
                        selectedValues: state.typeFilter,
                        onChanged: context
                            .read<ParkSpotPendingVerificationListBloc>()
                            .onTypeFilterChanged,
                        items: Enum$ParkSpotType.values.toFilterItems(context),
                      ),
                    ],
                    columns: [
                      DataColumn(label: Text(context.tr.name)),
                      DataColumn(label: Text(context.tr.type)),
                      DataColumn(label: Text(context.tr.mobileNumber)),
                      DataColumn2(
                        label: Text(context.tr.status),
                        size: ColumnSize.S,
                      ),
                      const DataColumn(label: SizedBox()),
                    ],
                    getRowCount: (data) => data.parkSpots.nodes.length,
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data.parkSpots.nodes[index]),
                    getPageInfo: (data) => data.parkSpots.pageInfo,
                    data: state.parkSpotsState,
                    paging: state.paging,
                    onPageChanged: context
                        .read<ParkSpotPendingVerificationListBloc>()
                        .onPageChanged,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$parkingListItem node) {
    return DataRow(
      cells: [
        DataCell(node.tableView(context)),
        DataCell(node.type.toChip(context)),
        DataCell(
          AppLinkButton(
            text: node.phoneNumber?.formatPhoneNumber(null) ?? "-",
            onPressed: () {
              launchUrlString("tel:+${node.phoneNumber}");
            },
          ),
        ),
        DataCell(node.status.toChip(context)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppFilledButton(
                text: context.tr.verify,
                onPressed: () {
                  context.router.push(ParkSpotCreateRoute(parkSpotId: node.id));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
