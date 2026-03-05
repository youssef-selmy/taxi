import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/parking_payout_session_status_sort_fields.dart';
import 'package:admin_frontend/core/enums/payout_session_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_list/presentation/blocs/parking_payout_session_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingPayoutSessionListSessionsList extends StatelessWidget {
  const ParkingPayoutSessionListSessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingPayoutSessionListBloc>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            BlocBuilder<
              ParkingPayoutSessionListBloc,
              ParkingPayoutSessionListState
            >(
              builder: (context, state) {
                return AppDataTable(
                  useSafeArea: false,
                  title: context.tr.payoutSessions,
                  minWidth: 600,
                  isHeaderTransparent: true,
                  sortOptions: _tableSortOptions(context, state),
                  filterOptions: [_tableStatusFilter(context, state)],
                  columns: [DataColumn(label: Text(context.tr.list))],
                  getRowCount: (data) =>
                      data.parkingPayoutSessions.nodes.length,
                  rowBuilder: (data, index) => _rowBuilder(
                    context,
                    data.parkingPayoutSessions.nodes[index],
                  ),
                  getPageInfo: (data) => data.parkingPayoutSessions.pageInfo,
                  data: state.payoutSessionsState,
                  paging: state.sessionsPaging,
                  onPageChanged: bloc.onSessionsPageChanged,
                );
              },
            ),
      ),
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$parkingPayoutSessionListItem node,
  ) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          ParkingPayoutSessionDetailRoute(payoutSessionId: node.id),
        );
      },
      cells: [
        DataCell(
          Row(
            children: [
              node.parkingTransactions.nodes
                  .map((transaction) => transaction.customer.media)
                  .toList()
                  .avatarsView(
                    context: context,
                    totalCount: node.parkingTransactions.totalCount,
                    size: AvatarGroupSize.medium,
                  ),
              const SizedBox(width: 16),
              Text(
                "${context.tr.session} #${node.id}",
                style: context.textTheme.labelMedium,
              ),
              const SizedBox(width: 12),
              node.status.toChip(context),
              const Spacer(flex: 3),
              Text(
                "${context.tr.total}: ",
                style: context.textTheme.labelMedium?.variant(context),
              ),
              node.totalAmount.toCurrency(context, node.currency),
              const Spacer(),
              ...node.payoutMethods.map(
                (payoutMethod) => payoutMethod.tableView(context),
              ),
              const SizedBox(width: 16),
              Text(
                node.createdAt.formatDateTime,
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppSortDropdown<Input$ParkingPayoutSessionSort> _tableSortOptions(
    BuildContext context,
    ParkingPayoutSessionListState state,
  ) {
    final bloc = context.read<ParkingPayoutSessionListBloc>();
    return AppSortDropdown(
      onChanged: (p0) => bloc.onSessionsSortChanged,
      items: [
        Input$ParkingPayoutSessionSort(
          field: Enum$ParkingPayoutSessionSortFields.totalAmount,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingPayoutSessionSort(
          field: Enum$ParkingPayoutSessionSortFields.totalAmount,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ParkingPayoutSessionSort(
          field: Enum$ParkingPayoutSessionSortFields.status,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingPayoutSessionSort(
          field: Enum$ParkingPayoutSessionSortFields.status,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      selectedValues: state.payoutSessionSort,
      labelGetter: (object) =>
          object.field.tableViewSortLabel(context, object.direction),
    );
  }

  AppFilterDropdown<Enum$PayoutSessionStatus> _tableStatusFilter(
    BuildContext context,
    ParkingPayoutSessionListState state,
  ) {
    final bloc = context.read<ParkingPayoutSessionListBloc>();
    return AppFilterDropdown<Enum$PayoutSessionStatus>(
      selectedValues: state.payoutSessionStatusFilter,
      title: context.tr.status,
      items: Enum$PayoutSessionStatus.values.toFilterItems(context),
      onChanged: bloc.onSessionStatusFilterChanged,
    );
  }
}
