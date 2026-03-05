import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockWeekdaySchedule1 = Fragment$weekdaySchedule(
  weekday: Enum$Weekday.Sunday,
  openingHours: [
    Fragment$weekdaySchedule$openingHours(open: "07:00", close: "22:00"),
  ],
);

final mockWeekdaySchedule2 = Fragment$weekdaySchedule(
  weekday: Enum$Weekday.Monday,
  openingHours: [
    Fragment$weekdaySchedule$openingHours(open: "07:00", close: "22:00"),
  ],
);

final mockWeekdaySchedules = [mockWeekdaySchedule1, mockWeekdaySchedule2];
