import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/enums/shop_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';

extension ShopOrderListItemX on Fragment$shopOrderListItem {
  Widget toCardContent(
    BuildContext context,
    Function(Fragment$shopOrderListItem item) onPressed,
  ) => CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      onPressed(this);
    },
    minimumSize: Size(0, 0),
    child: Column(
      children: [
        Row(
          children: [
            status.chip(context),
            const Spacer(),
            Text(
              "#$id",
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        customer.tableView(context),
        const SizedBox(height: 8),
        const SizedBox(height: 16),
        Row(
          children: [
            total.toCurrency(context, currency),
            Spacer(),
            paymentMethod.tableViewPaymentMethod(
              context,
              savedPaymentMethod,
              paymentGateway,
            ),
          ],
        ),
      ],
    ),
  );
}
