import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension DriverEnumSortField on Enum$DriverSortFields {
  String tableViewSortLabel(
    BuildContext context,
    Enum$SortDirection direction,
  ) {
    switch (this) {
      case Enum$DriverSortFields.id:
        return '${context.tr.id} ${direction.titleNumber(context)}';
      case Enum$DriverSortFields.status:
        return '${context.tr.status} ${direction.titleText(context)}';
      case Enum$DriverSortFields.lastName:
        return '${context.tr.lastName} ${direction.titleText(context)}';
      case Enum$DriverSortFields.fleetId:
        return '${context.tr.fleetId} ${direction.titleNumber(context)}';
      default:
        return 'Not implemented';
    }
  }
}
