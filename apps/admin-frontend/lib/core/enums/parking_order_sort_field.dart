import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TaxiEnumSortField on Enum$ParkOrderSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ParkOrderSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ParkOrderSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';
      case Enum$ParkOrderSortFields.price:
        return '${context.tr.cost} ${direction.titleAmount(context)}';
      case Enum$ParkOrderSortFields.paymentMode:
        return '${context.tr.paymentMethod} ${direction.titleText(context)}';
      default:
        return 'Not implemented';
    }
  }
}
