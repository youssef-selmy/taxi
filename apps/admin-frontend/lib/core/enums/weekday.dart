import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension WeekdayGQLX on Enum$Weekday {
  String name(BuildContext context) {
    switch (this) {
      case Enum$Weekday.Monday:
        return context.tr.monday;
      case Enum$Weekday.Tuesday:
        return context.tr.tuesday;
      case Enum$Weekday.Wednesday:
        return context.tr.wednesday;
      case Enum$Weekday.Thursday:
        return context.tr.thursday;
      case Enum$Weekday.Friday:
        return context.tr.friday;
      case Enum$Weekday.Saturday:
        return context.tr.saturday;
      case Enum$Weekday.Sunday:
        return context.tr.sunday;
      case Enum$Weekday.$unknown:
        return context.tr.unknown;
    }
  }
}
