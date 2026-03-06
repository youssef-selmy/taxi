class TimeRange {
  final DateTime start;
  final DateTime? end;

  TimeRange(this.start, this.end);
}

class TimesheetEntry {
  final DateTime date;
  final List<TimeRange> timeRanges;

  TimesheetEntry(this.date, this.timeRanges);
}
