import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/parking_transaction_credit_type.enum.dart';
import 'package:admin_frontend/core/enums/parking_transaction_debit_type.enum.dart';
import 'package:admin_frontend/core/enums/transaction_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_gateway_compact.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingTransactionFragmentX on Fragment$parkingTransaction {
  String typeString(BuildContext context) {
    String actionString = type.name(context);
    String typeString = type == Enum$TransactionType.Credit
        ? creditType?.title(context) ?? ""
        : debitType?.title(context) ?? "";
    return '$actionString - $typeString';
  }

  Widget tableViewType(BuildContext context) {
    return Row(
      children: [
        type.icon(context),
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
        color: type == Enum$TransactionType.Debit
            ? context.colors.error
            : context.colors.success,
      ),
    );
  }
}

extension ParkingTransactionPayoutFragmentX
    on Fragment$parkingTransactionPayout {
  String typeString(BuildContext context) {
    String actionString = type.name(context);
    String typeString = type == Enum$TransactionType.Credit
        ? creditType?.name ?? ""
        : debitType?.name ?? "";
    return '$actionString - $typeString';
  }

  Widget tableViewType(BuildContext context) {
    return Row(
      children: [
        type.icon(context),
        const SizedBox(width: 8),
        Text(typeString(context), style: context.textTheme.labelMedium),
      ],
    );
  }

  Widget amountView(BuildContext context) {
    return Text(
      amount.formatCurrency(currency),
      style: context.textTheme.labelMedium?.copyWith(
        color: type == Enum$TransactionType.Debit
            ? context.colors.error
            : context.colors.success,
      ),
    );
  }
}
