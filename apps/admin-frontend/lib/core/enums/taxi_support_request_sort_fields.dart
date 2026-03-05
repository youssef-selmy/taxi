import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TaxiSupportRequestSortFieldsX on Enum$TaxiSupportRequestSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$TaxiSupportRequestSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$TaxiSupportRequestSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';

      default:
        return 'Not implemented';
    }
  }
}
