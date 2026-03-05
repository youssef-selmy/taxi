import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopSupportRequestSortFieldsX on Enum$ShopSupportRequestSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ShopSupportRequestSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ShopSupportRequestSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';

      default:
        return 'Not implemented';
    }
  }
}
