import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingTransactionSortFieldsX on Enum$ParkingTransactionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ParkingTransactionSortFields.id:
        return "${context.tr.id} (${direction.titleText(context)})";
      case Enum$ParkingTransactionSortFields.amount:
        return "${context.tr.amount} (${direction.titleAmount(context)})";
      case Enum$ParkingTransactionSortFields.status:
        return "${context.tr.status} (${direction.titleText(context)})";
      default:
        return "Label not defined";
    }
  }
}
