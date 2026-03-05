import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension CustomerTransactionSortFieldsX on Enum$RiderTransactionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$RiderTransactionSortFields.action:
        return "${context.tr.type} (${direction.titleText(context)})";
      case Enum$RiderTransactionSortFields.createdAt:
        return "${context.tr.dateAndTime} (${direction.titleTime(context)})";
      case Enum$RiderTransactionSortFields.amount:
        return "${context.tr.amount} (${direction.titleAmount(context)})";
      case Enum$RiderTransactionSortFields.status:
        return "${context.tr.status} (${direction.titleText(context)})";
      default:
        return context.tr.labelNotDefined;
    }
  }
}
