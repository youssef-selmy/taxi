import 'package:better_design_system/molecules/time_sheet/time_sheet.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'soft', type: AppTimeSheet)
Widget appTimeSheet(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(50),
    child: AppTimeSheet(
      isLoading: context.knobs.boolean(label: 'Loading', initialValue: false),
      onWeekChanged: (startDate, endDate) {},
      currentStartDateTime: DateTime(2025, 7, 6),
      entries: [
        TimesheetEntry(DateTime(2025, 8, 3), [
          TimeRange(DateTime(2025, 8, 3, 9, 0), DateTime(2025, 8, 3, 14, 0)),
          TimeRange(DateTime(2025, 8, 3, 15, 0), DateTime(2025, 8, 3, 18, 30)),
        ]),
        TimesheetEntry(DateTime(2025, 7, 6), [
          TimeRange(DateTime(2025, 7, 6, 9, 0), DateTime(2025, 7, 6, 14, 0)),
          TimeRange(DateTime(2025, 7, 6, 15, 0), DateTime(2025, 7, 6, 18, 30)),
        ]),
        TimesheetEntry(DateTime(2025, 7, 7), [
          TimeRange(DateTime(2025, 7, 7, 8, 0), DateTime(2025, 7, 7, 12, 0)),
          TimeRange(DateTime(2025, 7, 7, 13, 0), DateTime(2025, 7, 7, 15, 30)),
          TimeRange(DateTime(2025, 7, 7, 16, 30), DateTime(2025, 7, 7, 20, 15)),
          TimeRange(DateTime(2025, 7, 7, 21, 0), DateTime(2025, 7, 7, 23, 0)),
          TimeRange(DateTime(2025, 7, 7, 23, 30), DateTime(2025, 7, 7, 23, 45)),
        ]),
        TimesheetEntry(DateTime(2025, 7, 8), [
          TimeRange(DateTime(2025, 7, 8, 11, 0), DateTime(2025, 7, 8, 20, 0)),
        ]),
        TimesheetEntry(DateTime(2025, 7, 9), [
          TimeRange(DateTime(2025, 7, 9, 9, 30), DateTime(2025, 7, 9, 11, 0)),
          TimeRange(DateTime(2025, 7, 9, 13, 0), DateTime(2025, 7, 9, 14, 0)),
          TimeRange(DateTime(2025, 7, 9, 15, 30), DateTime(2025, 7, 9, 18, 0)),
        ]),
        TimesheetEntry(DateTime(2025, 7, 31), [
          TimeRange(DateTime(2025, 7, 31, 7, 0), DateTime(2025, 7, 31, 8, 0)),
          TimeRange(DateTime(2025, 7, 31, 9, 0), DateTime(2025, 7, 31, 10, 0)),
          TimeRange(DateTime(2025, 7, 31, 11, 0), DateTime(2025, 7, 31, 13, 0)),
          TimeRange(
            DateTime(2025, 7, 31, 14, 0),
            DateTime(2025, 7, 31, 15, 30),
          ),
        ]),
      ],
      maxWeeklySeconds: 252000,
      maxDailySeconds: 40000,
    ),
  );
}
