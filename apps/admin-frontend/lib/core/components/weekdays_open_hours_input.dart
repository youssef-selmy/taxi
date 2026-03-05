import 'package:better_design_system/atoms/input_fields/time_field/time_field.dart';
import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:admin_frontend/core/enums/weekday.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

class WeekdaysOpenHoursInput extends StatelessWidget {
  final List<Input$WeekdayScheduleInput> openHours;
  final Function(List<Input$WeekdayScheduleInput>) onChanged;

  const WeekdaysOpenHoursInput({
    super.key,
    required this.openHours,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final weekday in Enum$Weekday.values.where(
          (weekday) => weekday != Enum$Weekday.$unknown,
        ))
          Row(
            children: [
              SizedBox(
                width: 130,
                child: Row(
                  children: [
                    Checkbox(
                      value: openHours.any(
                        (element) => element.weekday == weekday,
                      ),
                      onChanged: (value) {
                        if (value == true) {
                          onChanged([
                            ...openHours,
                            Input$WeekdayScheduleInput(
                              weekday: weekday,
                              openingHours: [
                                Input$OpeningHoursInput(
                                  open: "00:00",
                                  close: "23:59",
                                ),
                              ],
                            ),
                          ]);
                        } else {
                          onChanged(
                            openHours
                                .where((element) => element.weekday != weekday)
                                .toList(),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(weekday.name(context)),
                  ],
                ),
              ),
              if (openHours.any((element) => element.weekday == weekday)) ...[
                const Spacer(flex: 2),
                AppTimeField(
                  defaultValue: _timeOfDayFromTime(
                    openHours
                        .firstWhereOrNull(
                          (element) => element.weekday == weekday,
                        )
                        ?.openingHours
                        .firstOrNull
                        ?.open,
                  ),
                  onChanged: (time) {
                    final index = openHours.indexWhere(
                      (element) => element.weekday == weekday,
                    );
                    onChanged([
                      if (index != -1) ...[
                        ...openHours.where(
                          (element) => element.weekday != weekday,
                        ),
                        Input$WeekdayScheduleInput(
                          weekday: weekday,
                          openingHours: [
                            Input$OpeningHoursInput(
                              open: time?.format(context) ?? "00:00",
                              close:
                                  openHours[index]
                                      .openingHours
                                      .firstOrNull
                                      ?.close ??
                                  "23:59",
                            ),
                          ],
                        ),
                      ] else ...[
                        ...openHours,
                        Input$WeekdayScheduleInput(
                          weekday: weekday,
                          openingHours: [
                            Input$OpeningHoursInput(
                              open: time?.format(context) ?? "00:00",
                              close: "23:59",
                            ),
                          ],
                        ),
                      ],
                    ]);
                  },
                ),
                const Spacer(),
                AppTimeField(
                  defaultValue: _timeOfDayFromTime(
                    openHours
                        .firstWhereOrNull(
                          (element) => element.weekday == weekday,
                        )
                        ?.openingHours
                        .firstOrNull
                        ?.close,
                  ),
                  onChanged: (time) {
                    final index = openHours.indexWhere(
                      (element) => element.weekday == weekday,
                    );
                    onChanged([
                      if (index != -1) ...[
                        ...openHours.where(
                          (element) => element.weekday != weekday,
                        ),
                        Input$WeekdayScheduleInput(
                          weekday: weekday,
                          openingHours: [
                            Input$OpeningHoursInput(
                              open:
                                  openHours[index]
                                      .openingHours
                                      .firstOrNull
                                      ?.open ??
                                  "00:00",
                              close: time?.format(context) ?? "23:59",
                            ),
                          ],
                        ),
                      ] else ...[
                        ...openHours,
                        Input$WeekdayScheduleInput(
                          weekday: weekday,
                          openingHours: [
                            Input$OpeningHoursInput(
                              open: "00:00",
                              close: time?.format(context) ?? "23:59",
                            ),
                          ],
                        ),
                      ],
                    ]);
                  },
                ),
                const Spacer(),
              ],
              if (!openHours.any((element) => element.weekday == weekday)) ...[
                const Spacer(),
                Text(
                  context.tr.unavailable,
                  style: context.textTheme.bodyMedium?.apply(
                    color: context.colors.error,
                  ),
                ),
                const Spacer(flex: 7),
              ],
            ],
          ),
      ].separated(separator: const Divider(height: 32)),
    );
  }

  TimeOfDay? _timeOfDayFromTime(String? time) {
    if (time == null) {
      return null;
    }
    final parts = time.split(' ')[0].split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
