import 'package:better_design_system/molecules/kanban_board/kanban_board.dart';
import 'package:better_design_system/molecules/kanban_board/model/card_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_orders.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/dialogs/shop_detail_order_detail_dialog.dart';

class ShopDetailOrdersActiveTab extends StatefulWidget {
  final String shopId;

  const ShopDetailOrdersActiveTab({super.key, required this.shopId});

  @override
  State<ShopDetailOrdersActiveTab> createState() =>
      _ShopDetailOrdersActiveTabState();
}

class _ShopDetailOrdersActiveTabState extends State<ShopDetailOrdersActiveTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopDetailOrdersBloc, ShopDetailOrdersState>(
      builder: (context, state) {
        return AppKanbanBoard(
          columns: [
            KColumn(
              header: KColumnHeader(title: context.tr.onHold),
              value: 0,
              children: state.onHoldOrders
                  .map(
                    (order) => CardItem(
                      id: order.id,
                      widget: order.toCardContent(context, showOrderDetail),
                    ),
                  )
                  .toList(),
            ),
            KColumn(
              header: KColumnHeader(title: context.tr.open),
              value: 1,
              children: state.openOrders
                  .map(
                    (order) => CardItem(
                      id: order.id,
                      widget: order.toCardContent(context, showOrderDetail),
                    ),
                  )
                  .toList(),
            ),
            KColumn(
              header: KColumnHeader(title: context.tr.outForDelivery),
              value: 2,
              children: state.outForDeliveryOrders
                  .map(
                    (order) => CardItem(
                      id: order.id,
                      widget: order.toCardContent(context, showOrderDetail),
                    ),
                  )
                  .toList(),
            ),
            KColumn(
              header: KColumnHeader(title: context.tr.processing),
              value: 3,
              children: state.processingOrders
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

  void showOrderDetail(Fragment$shopOrderListItem item) {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) =>
          ShopDetailOrderDetailDialog(orderId: item.id, shopId: widget.shopId),
    );
  }
}
