import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ProviderTransactionSortFieldX on Enum$ProviderTransactionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ProviderTransactionSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ProviderTransactionSortFields.action:
        return "${context.tr.transactionType} ${direction.titleText(context)}";
      case Enum$ProviderTransactionSortFields.rechargeType:
        return "${context.tr.creditType} ${direction.titleText(context)}";
      case Enum$ProviderTransactionSortFields.deductType:
        return "${context.tr.debitType} ${direction.titleText(context)}";
      case Enum$ProviderTransactionSortFields.expenseType:
        return "${context.tr.expenseType} ${direction.titleText(context)}";
      default:
        return 'Not implemented';
    }
  }
}
