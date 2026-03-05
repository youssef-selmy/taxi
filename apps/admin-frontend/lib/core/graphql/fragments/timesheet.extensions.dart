import 'package:admin_frontend/core/graphql/fragments/timesheet.fragment.graphql.dart';
import 'package:better_design_system/molecules/time_sheet/time_sheet_entry.dart';

extension TimesheetGqlX on Fragment$Timesheet {
  TimesheetEntry toEntry() {
    return TimesheetEntry(
      date,
      timeRanges.map((e) => TimeRange(e.startTime, e.endTime)).toList(),
    );
  }
}

extension TimesheetListGqlX on List<Fragment$Timesheet> {
  List<TimesheetEntry> toEntries() {
    return map((e) => e.toEntry()).toList();
  }
}
