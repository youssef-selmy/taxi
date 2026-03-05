import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ParkingFeedbackSortFields on Enum$ParkingFeedbackSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$ParkingFeedbackSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$ParkingFeedbackSortFields.parkSpotId:
        return '${context.tr.parking} ${direction.titleNumber(context)}';
      case Enum$ParkingFeedbackSortFields.customerId:
        return '${context.tr.customer} ${direction.titleNumber(context)}';
      default:
        return 'Not implemented';
    }
  }
}
