import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/transaction_action.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension DriverTransactionFragmentX on Fragment$driverTransaction {
  String typeString(BuildContext context) {
    String actionString = action.name(context);
    String? typeString = action == Enum$TransactionAction.Recharge
        ? rechargeType?.name
        : deductType?.name;
    return typeString != null ? '$actionString - $typeString' : actionString;
  }

  Widget tableViewType(BuildContext context) {
    return Row(
      children: [
        action.icon(context),
        const SizedBox(width: 8),
        Text(typeString(context), style: context.textTheme.labelMedium),
      ],
    );
  }

  Widget tableViewPaymentMethod(BuildContext context) {
    if (savedPaymentMethod != null) {
      return savedPaymentMethod!.tableView(context);
    } else if (paymentGateway != null) {
      return paymentGateway!.tableView(context);
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

extension Fragment$driverTransactionPayoutX
    on Fragment$driverTransactionPayout {
  Widget amountView(BuildContext context) {
    return Text(
      amount.formatCurrency(currency),
      style: context.textTheme.labelMedium?.copyWith(
        color: action == Enum$TransactionAction.Deduct
            ? context.colors.error
            : context.colors.success,
      ),
    );
  }
}
