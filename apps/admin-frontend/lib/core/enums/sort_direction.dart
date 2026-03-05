import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension SortDirectionX on Enum$SortDirection {
  String titleTime(BuildContext context) {
    switch (this) {
      case Enum$SortDirection.ASC:
        return context.tr.oldToNew;
      case Enum$SortDirection.DESC:
        return context.tr.newToOld;
      case Enum$SortDirection.$unknown:
        return context.tr.unknown;
    }
  }

  String titleText(BuildContext context) {
    switch (this) {
      case Enum$SortDirection.ASC:
        return context.tr.aToZ;
      case Enum$SortDirection.DESC:
        return context.tr.zToA;
      case Enum$SortDirection.$unknown:
        return context.tr.unknown;
    }
  }

  String titleAmount(BuildContext context) {
    switch (this) {
      case Enum$SortDirection.ASC:
        return context.tr.lowToHigh;
      case Enum$SortDirection.DESC:
        return context.tr.highToLow;
      case Enum$SortDirection.$unknown:
        return context.tr.unknown;
    }
  }

  String titleNumber(BuildContext context) {
    switch (this) {
      case Enum$SortDirection.ASC:
        return context.tr.ascending;
      case Enum$SortDirection.DESC:
        return context.tr.descending;
      case Enum$SortDirection.$unknown:
        return context.tr.unknown;
    }
  }
}
