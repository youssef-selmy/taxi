import 'package:better_design_system/molecules/weekdays_open_hours_input/weekdays_open_hours_input.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppWeekdaysScheduleField)
Widget defaultAppWeekdaysScheduleField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(100),
    child: SizedBox(
      width: 460,
      child: AppWeekdaysScheduleField(
        onChanged: (_) {},
        openHours: [
          (
            Weekday.sunday,
            [
              (TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 12, minute: 0)),
              (TimeOfDay(hour: 13, minute: 0), TimeOfDay(hour: 18, minute: 0)),
            ],
          ),
          (
            Weekday.monday,
            [
              (TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 12, minute: 0)),
              (TimeOfDay(hour: 13, minute: 0), TimeOfDay(hour: 18, minute: 0)),
            ],
          ),
        ],
      ),
    ),
  );
}
