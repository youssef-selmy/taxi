import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkSpotSortFieldsX on Enum$ParkSpotSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ParkSpotSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ParkSpotSortFields.ratingAggregate:
        return '${context.tr.rating} ${direction.titleNumber(context)}';
      default:
        return 'Not implemented';
    }
  }
}
