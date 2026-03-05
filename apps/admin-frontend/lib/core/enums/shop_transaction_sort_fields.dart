import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopTransactionSortFieldsX on Enum$ShopTransactionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ShopTransactionSortFields.id:
        return "${context.tr.id} (${direction.titleText(context)})";
      case Enum$ShopTransactionSortFields.amount:
        return "${context.tr.amount} (${direction.titleAmount(context)})";
      case Enum$ShopTransactionSortFields.status:
        return "${context.tr.status} (${direction.titleText(context)})";
      default:
        return context.tr.labelNotDefined;
    }
  }
}
