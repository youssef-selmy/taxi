import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopSortFieldsX on Enum$ShopSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ShopSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ShopSortFields.name:
        return '${context.tr.name} ${direction.titleText(context)}';
      case Enum$ShopSortFields.ratingAggregate:
        return '${context.tr.rating} ${direction.titleText(context)}';
      case Enum$ShopSortFields.$unknown:
        return 'Not implemented';
      case Enum$ShopSortFields.displayPriority:
        return '${context.tr.displayPriority} ${direction.titleNumber(context)}';
      case Enum$ShopSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';
      case Enum$ShopSortFields.recommendedScore:
        return 'Recommendation Score ${direction.titleText(context)}';
    }
  }
}
