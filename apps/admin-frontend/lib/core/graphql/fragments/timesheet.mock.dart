import 'package:admin_frontend/core/graphql/fragments/timesheet.fragment.graphql.dart';

final mockTimesheet = [
  Fragment$Timesheet(
    date: DateTime.now(),
    timeRanges: [
      Fragment$Timesheet$timeRanges(
        startTime: DateTime.now().subtract(const Duration(hours: 8)),
        endTime: DateTime.now(),
      ),
    ],
  ),
  Fragment$Timesheet(
    date: DateTime.now().subtract(const Duration(days: 1)),
    timeRanges: [
      Fragment$Timesheet$timeRanges(
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        endTime: DateTime.now()
            .subtract(const Duration(days: 1))
            .add(const Duration(hours: 8)),
      ),
    ],
  ),
  Fragment$Timesheet(
    date: DateTime.now().subtract(const Duration(days: 2)),
    timeRanges: [
      Fragment$Timesheet$timeRanges(
        startTime: DateTime.now().subtract(const Duration(days: 2)),
        endTime: DateTime.now()
            .subtract(const Duration(days: 2))
            .add(const Duration(hours: 8)),
      ),
    ],
  ),
  Fragment$Timesheet(
    date: DateTime.now().subtract(const Duration(days: 3)),
    timeRanges: [
      Fragment$Timesheet$timeRanges(
        startTime: DateTime.now().subtract(const Duration(days: 3)),
        endTime: DateTime.now()
            .subtract(const Duration(days: 3))
            .add(const Duration(hours: 8)),
      ),
    ],
  ),
];
