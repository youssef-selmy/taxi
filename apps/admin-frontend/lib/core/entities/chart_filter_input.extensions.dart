import 'package:intl/intl.dart';

import 'package:admin_frontend/schema.graphql.dart';

extension ChartIntervalX on Enum$ChartInterval {
  String format(DateTime date) => switch (this) {
    Enum$ChartInterval.Daily => DateFormat('dd.MM.yyyy').format(date),
    Enum$ChartInterval.Quarterly => 'Q${(date.month / 3).ceil()} ${date.year}',
    Enum$ChartInterval.Monthly => DateFormat('MMM').format(date),
    Enum$ChartInterval.Yearly => '${date.year}',
    Enum$ChartInterval.$unknown => throw Exception('Unknown interval'),
  };
}
