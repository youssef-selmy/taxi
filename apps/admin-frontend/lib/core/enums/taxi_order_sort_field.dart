import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TaxiEnumSortField on Enum$OrderSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$OrderSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$OrderSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';
      case Enum$OrderSortFields.costBest:
        return '${context.tr.cost} ${direction.titleAmount(context)}';
      case Enum$OrderSortFields.paymentMode:
        return '${context.tr.paymentMethod} ${direction.titleText(context)}';
      case Enum$OrderSortFields.currency:
        return '${context.tr.currency} ${direction.titleText(context)}';
      case Enum$OrderSortFields.createdOn:
        return '${context.tr.create} ${direction.titleNumber(context)}';
      default:
        return 'Not implemented';
    }
  }
}
