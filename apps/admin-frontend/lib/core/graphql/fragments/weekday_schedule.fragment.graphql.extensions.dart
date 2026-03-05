import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:admin_frontend/core/enums/weekday.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension WeekdayScheduleFragmentExtension on Fragment$weekdaySchedule {
  Widget toChip(BuildContext context) {
    return AppTag(
      text:
          "${weekday.name(context)}, ${openingHours.first.open} - ${openingHours.first.close}",
      color: SemanticColor.neutral,
    );
  }

  Input$WeekdayScheduleInput toInput() {
    return Input$WeekdayScheduleInput(
      weekday: weekday,
      openingHours: openingHours.map((e) => e.toInput()).toList(),
    );
  }
}

extension OpeningHourX on Fragment$weekdaySchedule$openingHours {
  Input$OpeningHoursInput toInput() {
    return Input$OpeningHoursInput(open: open, close: close);
  }
}

extension WeekdayScheduleFragmentListExtension
    on List<Fragment$weekdaySchedule> {
  Widget toChips(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: map((e) => e.toChip(context)).toList(),
    );
  }

  List<Input$WeekdayScheduleInput> toInput() {
    return map((e) => e.toInput()).toList();
  }
}
