import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/customer_deposit_transaction_type.dart';
import 'package:admin_frontend/core/enums/customer_withdraw_transaction_type.dart';
import 'package:admin_frontend/core/enums/transaction_action.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension CustomerTransactionFragmentX on Fragment$customerTransaction {
  String typeString(BuildContext context) {
    String actionString = action.name(context);
    String typeString = action == Enum$TransactionAction.Recharge
        ? rechargeType?.name(context) ?? ""
        : deductType?.name(context) ?? "";
    return '$actionString - $typeString';
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

extension CustomerTransactionList on List<Fragment$customerTransaction> {
  double get sum =>
      fold(0, (previousValue, element) => previousValue + element.amount);
}
