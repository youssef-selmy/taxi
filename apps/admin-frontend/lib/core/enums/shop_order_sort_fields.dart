import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopOrderEnumSortField on Enum$ShopOrderSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ShopOrderSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ShopOrderSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';
      case Enum$ShopOrderSortFields.customerId:
        return '${context.tr.customer} ${direction.titleText(context)}';
      case Enum$ShopOrderSortFields.paymentMethod:
        return '${context.tr.paymentMethod} ${direction.titleText(context)}';

      default:
        return 'Not implemented';
    }
  }
}
