import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/blocs/taxi_orders_list.bloc.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/schema.graphql.dart';

class TaxiActiveOrdersTable extends StatelessWidget {
  const TaxiActiveOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaxiOrdersListBloc>();
    return BlocBuilder<TaxiOrdersListBloc, TaxiOrdersListState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: AppClickableCard(
            type: ClickableCardType.elevated,
            elevation: BetterShadow.shadow8,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      context.tr.activeOrders,
                      style: context.textTheme.titleSmall,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: AppTabMenuHorizontal<Enum$TaxiOrderStatus>(
                        style: TabMenuHorizontalStyle.soft,
                        color: SemanticColor.primary,

                        selectedValue: state.activeOrdersTab,
                        onChanged: (onChanged) {
                          bloc.add(
                            TaxiOrdersListEvent.statusFilterChanged([
                              onChanged,
                            ]),
                          );
                        },
                        tabs: [
                          TabMenuHorizontalOption(
                            value: Enum$TaxiOrderStatus.SearchingForDriver,
                            title: context.tr.pending,
                          ),
                          TabMenuHorizontalOption(
                            value: Enum$TaxiOrderStatus.OnTrip,
                            title: context.tr.onTrip,
                          ),
                          TabMenuHorizontalOption(
                            value: Enum$TaxiOrderStatus.Scheduled,
                            title: context.tr.scheduled,
                          ),
                        ],
                      ),
                    ),
                    AppTextButton(
                      size: ButtonSize.medium,
                      text: "Go to Archive",
                      suffixIcon: BetterIcons.arrowRight02Outline,
                      onPressed: () {
                        context.router.push(const TaxiOrderArchiveListRoute());
                      },
                    ),
                  ],
                ),
                const AppDivider(height: 24),
                SizedBox(
                  height: 600,
                  child: AppDataTable(
                    minWidth: 1100,
                    searchBarOptions: TableSearchBarOptions(enabled: false),
                    columns: [
                      DataColumn2(label: Text(context.tr.id), fixedWidth: 130),
                      DataColumn2(
                        label: Text(context.tr.customer),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text(context.tr.driver),
                        size: ColumnSize.L,
                      ),
                      DataColumn(label: Text(context.tr.dateAndTime)),
                      DataColumn(label: Text(context.tr.price)),
                      DataColumn(label: Text(context.tr.status)),
                    ],
                    filterOptions: [
                      AppFilterDropdown<Fragment$fleetListItem>(
                        title: context.tr.fleets,
                        selectedValues: state.fleetFilterList,
                        onChanged: (value) {
                          bloc.add(
                            TaxiOrdersListEvent.fleetFilterChanged(value),
                          );
                        },
                        items:
                            state.fleets.data?.fleets.nodes
                                .map(
                                  (fleet) => FilterItem(
                                    label: fleet.name,
                                    value: fleet,
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ],
                    getRowCount: (data) => data.taxiOrders.edges.length,
                    rowBuilder: (data, int index) => rowBuilder(
                      context,
                      data,
                      index,
                      state.selectedOrderId,
                      (orderId) {
                        bloc.add(TaxiOrdersListEvent.selectOrder(orderId));
                      },
                    ),
                    getPageInfo: (data) =>
                        data.taxiOrders.pageInfo.offsetPageInfo,
                    data: state.ordersList,
                    paging: state.paging,
                    onPageChanged: (page) {
                      bloc.add(TaxiOrdersListEvent.pageChanged(page));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

DataRow rowBuilder(
  BuildContext context,
  Query$taxiOrders data,
  int index,
  String? selectedOrderId,
  Function(String) onSelectChanged,
) {
  final order = data.taxiOrders.edges[index];
  return DataRow(
    selected: order.id == selectedOrderId,
    onSelectChanged: (value) {
      onSelectChanged(order.id);
    },
    cells: [
      DataCell(
        Row(
          children: [
            AppRadio(
              value: order.id,
              groupValue: selectedOrderId,
              onTap: (value) {
                onSelectChanged(order.id);
              },
            ),
            SizedBox(width: 24),
            Text(
              '#${order.id}',
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
      ),
      DataCell(
        AppProfileCell(
          name: order.rider.fullName ?? "N/A",
          imageUrl: order.rider.imageUrl,
          subtitle: order.rider.mobileNumber.formatPhoneNumber(null),
        ),
      ),
      DataCell(
        AppProfileCell(
          name: order.driver?.fullName ?? context.tr.searching,
          imageUrl: order.driver?.imageUrl,
          subtitle: order.driver?.mobileNumber.formatPhoneNumber(null),
        ),
      ),
      DataCell(
        Text(
          order.createdAt.formatDateTime,
          style: context.textTheme.labelMedium,
        ),
      ),
      DataCell(order.totalCost.toCurrency(context, order.currency)),
      DataCell(order.status.chip(context)),
    ],
  );
}
