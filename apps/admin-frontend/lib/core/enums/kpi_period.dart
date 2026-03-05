import 'package:admin_frontend/schema.graphql.dart';
import 'package:flutter/widgets.dart';

extension KpiPeriodX on Enum$KPIPeriod {
  String title(BuildContext context) => switch (this) {
    Enum$KPIPeriod.Last7Days => 'Last 7 Days',
    Enum$KPIPeriod.Last30Days => 'Last 30 Days',
    Enum$KPIPeriod.Last90Days => 'Last 90 Days',
    Enum$KPIPeriod.Last365Days => 'Last 365 Days',
    _ => 'Unknown',
  };
}
