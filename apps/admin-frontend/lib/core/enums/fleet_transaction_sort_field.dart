import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension FleetTransactionEnumSortField on Enum$FleetTransactionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$FleetTransactionSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$FleetTransactionSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';

      default:
        return 'Not implemented';
    }
  }
}
