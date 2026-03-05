import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/transaction_action.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension FragmentAdminTransactionX on Fragment$adminTransactionListItem {
  String typeString(BuildContext context) {
    String actionString = action.name(context);
    String typeString = action == Enum$TransactionAction.Recharge
        ? rechargeType?.name(context) ?? ""
        : (deductType == Enum$ProviderDeductTransactionType.Expense
                  ? (expenseType?.name(context) ?? "")
                  : deductType?.name(context)) ??
              "";
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
}

extension EnumAdminRechargeTypeX on Enum$ProviderRechargeTransactionType {
  String name(BuildContext context) {
    switch (this) {
      case Enum$ProviderRechargeTransactionType.Commission:
        return context.tr.commission;
      case Enum$ProviderRechargeTransactionType.$unknown:
        return context.tr.unknown;
    }
  }
}

extension EnumAdminDeductTypeX on Enum$ProviderDeductTransactionType {
  String name(BuildContext context) {
    switch (this) {
      case Enum$ProviderDeductTransactionType.Withdraw:
        return context.tr.withdraw;
      case Enum$ProviderDeductTransactionType.$unknown:
        return context.tr.unknown;
      case Enum$ProviderDeductTransactionType.Expense:
        return context.tr.expense;
      case Enum$ProviderDeductTransactionType.Refund:
        return context.tr.refund;
    }
  }
}

extension EnumAdminExpenseTypeX on Enum$ProviderExpenseType {
  String name(BuildContext context) {
    switch (this) {
      case Enum$ProviderExpenseType.TechnologyDevelopment:
        return context.tr.technologyDevelopment;
      case Enum$ProviderExpenseType.PlatformMaintenance:
        return context.tr.platformMaintenance;
      case Enum$ProviderExpenseType.SoftwareLicense:
        return context.tr.softwareLicense;
      case Enum$ProviderExpenseType.Hosting:
        return context.tr.hosting;
      case Enum$ProviderExpenseType.CloudServices:
        return context.tr.cloudServices;
      case Enum$ProviderExpenseType.Marketing:
        return context.tr.marketing;
      case Enum$ProviderExpenseType.$unknown:
        return context.tr.unknown;
    }
  }
}
