import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension DriverTransactionSortFieldsX on Enum$DriverTransactionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$DriverTransactionSortFields.action:
        return "${context.tr.type} (${direction.titleText(context)})";
      case Enum$DriverTransactionSortFields.createdAt:
        return "${context.tr.dateAndTime} (${direction.titleTime(context)})";
      case Enum$DriverTransactionSortFields.amount:
        return "${context.tr.amount} (${direction.titleAmount(context)})";
      case Enum$DriverTransactionSortFields.status:
        return "${context.tr.status} (${direction.titleText(context)})";
      default:
        return "Label not defined";
    }
  }
}
