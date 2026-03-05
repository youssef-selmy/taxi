import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingSupportRequestSortFieldsX
    on Enum$ParkingSupportRequestSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ParkingSupportRequestSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ParkingSupportRequestSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';

      default:
        return 'Not implemented';
    }
  }
}
