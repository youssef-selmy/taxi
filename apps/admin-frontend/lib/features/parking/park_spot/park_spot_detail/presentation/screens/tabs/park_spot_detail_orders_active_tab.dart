import 'package:better_design_system/molecules/kanban_board/kanban_board.dart';
import 'package:better_design_system/molecules/kanban_board/model/card_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_orders.cubit.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/dialogs/park_spot_detail_order_detail_dialog.dart';

class ParkSpotDetailOrdersActiveTab extends StatefulWidget {
  final String parkSpotId;

  const ParkSpotDetailOrdersActiveTab({super.key, required this.parkSpotId});

  @override
  State<ParkSpotDetailOrdersActiveTab> createState() =>
      _ParkSpotDetailOrdersActiveTabState();
}

class _ParkSpotDetailOrdersActiveTabState
    extends State<ParkSpotDetailOrdersActiveTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkSpotDetailOrdersBloc, ParkSpotDetailOrdersState>(
      builder: (context, state) {
        return AppKanbanBoard(
          columns: [
            KColumn(
              header: KColumnHeader(title: context.tr.pending),
              value: 0,
              children: state.pendingOrders
                  .map(
                    (order) => CardItem(
                      id: order.id,
                      widget: order.toCardContent(context, showOrderDetail),
                    ),
                  )
                  .toList(),
            ),
            KColumn(
              header: KColumnHeader(title: context.tr.paid),
              value: 1,
              children: state.paidOrders
                  .map(
                    (order) => CardItem(
                      id: order.id,
                      widget: order.toCardContent(context, showOrderDetail),
                    ),
                  )
                  .toList(),
            ),
            KColumn(
              header: KColumnHeader(title: context.tr.accepted),
              value: 2,
              children: state.acceptedOrders
                  .map(
                    (order) => CardItem(
                      id: order.id,
                      widget: order.toCardContent(context, showOrderDetail),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }

  void showOrderDetail(Fragment$parkingOrderListItem item) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => ParkSpotDetailOrderDetailDialog(orderId: item.id),
    );
  }
}
