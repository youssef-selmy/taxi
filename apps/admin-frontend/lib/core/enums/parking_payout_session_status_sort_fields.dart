import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingPayoutSessionStatusSortFieldsX
    on Enum$ParkingPayoutSessionSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ParkingPayoutSessionSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ParkingPayoutSessionSortFields.status:
        return "${context.tr.status} ${direction.titleText(context)}";
      case Enum$ParkingPayoutSessionSortFields.totalAmount:
        return "${context.tr.amount} ${direction.titleNumber(context)}";
      default:
        return 'Not implemented';
    }
  }
}
