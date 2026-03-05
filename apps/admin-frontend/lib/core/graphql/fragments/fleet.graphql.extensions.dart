import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/wallet_balance/wallet_balance_item.dart';
import 'package:admin_frontend/core/enums/transaction_action.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/wallet.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension FleetWalletX on Fragment$fleetWallet {
  WalletBalanceItem toWalletBalanceItem() {
    return WalletBalanceItem(currency: currency, balance: balance);
  }
}

extension CustomerWalletListX on List<Fragment$fleetWallet> {
  List<WalletBalanceItem> toWalletBalanceItems() =>
      map((e) => e.toWalletBalanceItem()).toList();
}

extension FleetTransactionFragmentX on Fragment$fleetTransaction {
  String typeString(BuildContext context) {
    String actionString = action.name(context);
    String typeString = action == Enum$TransactionAction.Recharge
        ? rechargeType?.name ?? ""
        : deductType?.name ?? "";
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

  // Widget tableViewPaymentMethod(BuildContext context) {
  //   if (savedPaymentMethod != null) {
  //     return savedPaymentMethod!.tableView(context);
  //   } else if (paymentGateway != null) {
  //     return paymentGateway!.tableView(context);
  //   } else {
  //     return Row(
  //       children: [
  //         Icon(
  //           BetterIcons.wallet01Filled,
  //           color: context.colors.primary,
  //           size: 16,
  //         ),
  //         const SizedBox(
  //           width: 4,
  //         ),
  //         Transform.translate(
  //           offset: const Offset(0, -2),
  //           child: Text(
  //             context.translate.wallet,
  //             style: context.textTheme.labelMedium,
  //           ),
  //         ),
  //       ],
  //     );
  //   }
  // }

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
