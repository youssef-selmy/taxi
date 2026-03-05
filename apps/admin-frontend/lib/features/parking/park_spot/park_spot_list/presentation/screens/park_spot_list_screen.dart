import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/enums/park_spot_sort_fields.dart';
import 'package:admin_frontend/core/enums/park_spot_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/presentation/blocs/park_spot_list.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ParkSpotListScreen extends StatelessWidget {
  const ParkSpotListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkSpotListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: context.tr.parking,
              subtitle: context.tr.registeredParkingSpotsList,
            ),
            const SizedBox(height: 24),
            BlocBuilder<ParkSpotListBloc, ParkSpotListState>(
              builder: (context, state) {
                return AppToggleSwitchButtonGroup<Enum$ParkSpotType>(
                  selectedValue: state.parkSpotType,
                  onChanged: context.read<ParkSpotListBloc>().onTypeSelected,
                  options: [
                    ToggleSwitchButtonGroupOption(
                      label: context.tr.public,
                      value: Enum$ParkSpotType.PUBLIC,
                    ),
                    ToggleSwitchButtonGroupOption(
                      label: context.tr.personal,
                      value: Enum$ParkSpotType.PERSONAL,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<ParkSpotListBloc, ParkSpotListState>(
              builder: (context, state) {
                return Expanded(
                  child: AppDataTable(
                    minWidth: 1200,
                    searchBarOptions: TableSearchBarOptions(
                      enabled: true,
                      onChanged: context
                          .read<ParkSpotListBloc>()
                          .onSearchQueryChanged,
                      query: state.searchQuery,
                    ),
                    filterOptions: [
                      AppFilterDropdown<Enum$ParkSpotStatus>(
                        title: context.tr.status,
                        selectedValues: state.statusFilter,
                        onChanged: context
                            .read<ParkSpotListBloc>()
                            .onStatusFilterChanged,
                        items: Enum$ParkSpotStatus.values.toFilterItems(
                          context,
                        ),
                      ),
                    ],
                    sortOptions: AppSortDropdown<Input$ParkSpotSort>(
                      onChanged: context.read<ParkSpotListBloc>().onSortChanged,
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
                    actions: [
                      AppOutlinedButton(
                        onPressed: () {
                          context.router.push(ParkSpotCreateRoute());
                        },
                        text: context.tr.add,
                        prefixIcon: BetterIcons.addCircleOutline,
                      ),
                    ],
                    columns: [
                      DataColumn(label: Text(context.tr.name)),
                      DataColumn(label: Text(context.tr.mobileNumber)),
                      DataColumn2(
                        label: Text(context.tr.status),
                        size: ColumnSize.S,
                      ),
                      DataColumn(label: Text(context.tr.address)),
                      DataColumn2(
                        label: Text(context.tr.rating),
                        size: ColumnSize.S,
                      ),
                      DataColumn(label: Text(context.tr.walletBalance)),
                      DataColumn(label: Text(context.tr.totalOrders)),
                    ],
                    getRowCount: (data) => data.parkSpots.nodes.length,
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data.parkSpots.nodes[index]),
                    getPageInfo: (data) => data.parkSpots.pageInfo,
                    data: state.parkSpotsState,
                    paging: state.paging,
                    onPageChanged: context
                        .read<ParkSpotListBloc>()
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
      onSelectChanged: (value) {
        context.router.push(ParkSpotDetailRoute(parkSpotId: node.id));
      },
      cells: [
        DataCell(node.tableView(context)),
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
          Text(
            node.address ?? "-",
            style: context.textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(RatingIndicator(rating: node.ratingAggregate.rating)),
        DataCell(
          node.owner?.parkingWallets.toWalletBalanceItems().balanceText(
                context,
              ) ??
              Text("-"),
        ),
        DataCell(
          Text(
            context.tr.ordersCount(node.parkOrders.totalCount),
            style: context.textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
