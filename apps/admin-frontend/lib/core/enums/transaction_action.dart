import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TransactionActionX on Enum$TransactionAction {
  String name(BuildContext context) => switch (this) {
    Enum$TransactionAction.Recharge => context.tr.credit,
    Enum$TransactionAction.Deduct => context.tr.debit,
    Enum$TransactionAction.$unknown => context.tr.unknown,
  };

  Widget icon(BuildContext context) => switch (this) {
    Enum$TransactionAction.Recharge => Icon(
      BetterIcons.arrowUpRight01Outline,
      color: context.colors.success,
      size: 16,
    ),
    Enum$TransactionAction.Deduct => Icon(
      BetterIcons.arrowDownLeft01Outline,
      color: context.colors.error,
      size: 16,
    ),
    Enum$TransactionAction.$unknown => const Icon(
      Icons.error,
      color: Colors.grey,
      size: 16,
    ),
  };

  Widget tableViewPaymentMethod(
    BuildContext context,
    Fragment$SavedPaymentMethod? savedPaymentMethod,
    Fragment$paymentGatewayCompact? paymentGateway,
  ) {
    if (savedPaymentMethod != null) {
      return savedPaymentMethod.tableView(context);
    } else if (paymentGateway != null) {
      return paymentGateway.tableView(context);
    } else {
      return Row(
        children: [
          Icon(
            BetterIcons.wallet01Filled,
            color: context.colors.primary,
            size: 16,
          ),
          const SizedBox(width: 4),
          Transform.translate(
            offset: const Offset(0, -2),
            child: Text(
              context.tr.wallet,
              style: context.textTheme.labelMedium,
            ),
          ),
        ],
      );
    }
  }
}
