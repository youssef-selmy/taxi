import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';

extension ParkingOrderListItemX on Fragment$parkingOrderListItem {
  Widget toCardContent(
    BuildContext context,
    Function(Fragment$parkingOrderListItem item) onPressed,
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
            status.toChip(context),
            const Spacer(),
            Text(
              "#$id",
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (carOwner != null) carOwner!.tableView(context),
        const SizedBox(height: 8),
        const SizedBox(height: 16),
        Row(
          children: [
            price.toCurrency(context, currency),
            Spacer(),
            paymentMode.tableViewPaymentMethod(
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
