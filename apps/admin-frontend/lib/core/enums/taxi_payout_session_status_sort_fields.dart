import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TaxiPayoutSessionStatusSortFieldsX
    on Enum$TaxiPayoutSessionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$TaxiPayoutSessionSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$TaxiPayoutSessionSortFields.status:
        return "${context.tr.status} ${direction.titleText(context)}";
      case Enum$TaxiPayoutSessionSortFields.totalAmount:
        return "${context.tr.amount} ${direction.titleNumber(context)}";
      default:
        return 'Not implemented';
    }
  }
}
