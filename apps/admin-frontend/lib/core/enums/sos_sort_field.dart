import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension SosEnumSortField on Enum$DistressSignalSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$DistressSignalSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$DistressSignalSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';

      default:
        return 'Not implemented';
    }
  }
}
