import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../atoms/input_fields/time_field/time_field.dart';

typedef WeekdaySchedule = List<(TimeOfDay, TimeOfDay)>;

typedef BetterWeekdaysScheduleField = AppWeekdaysScheduleField;

class AppWeekdaysScheduleField extends StatefulWidget {
  final List<(Weekday, WeekdaySchedule)> openHours;
  final Function(List<(Weekday, WeekdaySchedule)>) onChanged;

  const AppWeekdaysScheduleField({
    super.key,
    required this.openHours,
    required this.onChanged,
  });

  @override
  AppWeekdaysScheduleFieldState createState() =>
      AppWeekdaysScheduleFieldState();
}

typedef BetterWeekdaysScheduleFieldState = AppWeekdaysScheduleFieldState;

class AppWeekdaysScheduleFieldState extends State<AppWeekdaysScheduleField> {
  late List<(Weekday, WeekdaySchedule)> expandedSchedules;
  Map<Weekday, bool> expansionState = {};

  @override
  void initState() {
    super.initState();
    expandedSchedules = widget.openHours;
    for (var weekday in Weekday.values) {
      expansionState[weekday] = false;
    }
  }

  @override
  void didUpdateWidget(covariant AppWeekdaysScheduleField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!const DeepCollectionEquality().equals(
      oldWidget.openHours,
      widget.openHours,
    )) {
      setState(() {
        expandedSchedules = widget.openHours;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colors.surfaceVariantLow,
        ),
        child: Column(
          children: Weekday.values.map((weekday) {
            final weekdayScheule = expandedSchedules.firstWhereOrNull(
              (element) => element.$1 == weekday,
            );
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (expansionState[weekday] ?? false)
                      ? context.colors.surfaceVariantLow
                      : context.colors.outline,
                ),
                borderRadius: BorderRadius.circular(10),
                color: context.colors.surface,
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: context.colors.transparent,
                  splashColor: context.colors.transparent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppCheckbox(
                          value: weekdayScheule != null,
                          onChanged: (value) {
                            if (value == true) {
                              widget.onChanged([
                                ...expandedSchedules,
                                (
                                  weekday,
                                  [
                                    (
                                      const TimeOfDay(hour: 0, minute: 0),
                                      const TimeOfDay(hour: 23, minute: 59),
                                    ),
                                  ],
                                ),
                              ]);
                            } else {
                              widget.onChanged(
                                expandedSchedules
                                    .where((element) => element.$1 != weekday)
                                    .toList(),
                              );
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            weekday.name(context),
                            style: context.textTheme.labelLarge,
                          ),
                        ),
                        if (weekdayScheule == null) ...[
                          const SizedBox(width: 8),
                          AppTag(
                            text: context.strings.unavailable,
                            color: SemanticColor.error,
                          ),
                        ],
                      ],
                    ),
                    enabled: weekdayScheule != null,
                    backgroundColor: weekdayScheule == null
                        ? context.colors.surface
                        : context.colors.surfaceVariantLow,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        expansionState[weekday] = expanded;
                      });
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            ...(weekdayScheule?.$2 ?? []).map((schedule) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            spacing: 8,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                context.strings.from,
                                                style: context
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                      color: context
                                                          .colors
                                                          .onSurfaceVariant,
                                                    ),
                                              ),
                                              AppTimeField(
                                                defaultValue: schedule.$1,
                                                onChanged: (time) {
                                                  final index =
                                                      expandedSchedules
                                                          .indexWhere(
                                                            (element) =>
                                                                element.$1 ==
                                                                weekday,
                                                          );
                                                  widget.onChanged([
                                                    if (index != -1) ...[
                                                      ...expandedSchedules
                                                          .where(
                                                            (element) =>
                                                                element.$1 !=
                                                                weekday,
                                                          ),
                                                      (
                                                        weekday,
                                                        [
                                                          (
                                                            time ??
                                                                const TimeOfDay(
                                                                  hour: 0,
                                                                  minute: 0,
                                                                ),
                                                            expandedSchedules[index]
                                                                    .$2
                                                                    .firstOrNull
                                                                    ?.$2 ??
                                                                const TimeOfDay(
                                                                  hour: 23,
                                                                  minute: 59,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ] else ...[
                                                      ...expandedSchedules,
                                                      (
                                                        weekday,
                                                        [
                                                          (
                                                            time ??
                                                                const TimeOfDay(
                                                                  hour: 0,
                                                                  minute: 0,
                                                                ),
                                                            const TimeOfDay(
                                                              hour: 23,
                                                              minute: 59,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ]);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            spacing: 8,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                context.strings.to,
                                                style: context
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                      color: context
                                                          .colors
                                                          .onSurfaceVariant,
                                                    ),
                                              ),
                                              AppTimeField(
                                                defaultValue: schedule.$2,
                                                onChanged: (time) {
                                                  final index =
                                                      expandedSchedules
                                                          .indexWhere(
                                                            (element) =>
                                                                element.$1 ==
                                                                weekday,
                                                          );
                                                  widget.onChanged([
                                                    if (index != -1) ...[
                                                      ...expandedSchedules
                                                          .where(
                                                            (element) =>
                                                                element.$1 !=
                                                                weekday,
                                                          ),
                                                      (
                                                        weekday,
                                                        [
                                                          (
                                                            expandedSchedules[index]
                                                                    .$2
                                                                    .firstOrNull
                                                                    ?.$1 ??
                                                                const TimeOfDay(
                                                                  hour: 0,
                                                                  minute: 0,
                                                                ),
                                                            time ??
                                                                const TimeOfDay(
                                                                  hour: 23,
                                                                  minute: 59,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ] else ...[
                                                      ...expandedSchedules,
                                                      (
                                                        weekday,
                                                        [
                                                          (
                                                            const TimeOfDay(
                                                              hour: 0,
                                                              minute: 0,
                                                            ),
                                                            time ??
                                                                const TimeOfDay(
                                                                  hour: 23,
                                                                  minute: 59,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ]);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    AppTextButton(
                                      text: context.strings.delete,
                                      color: SemanticColor.error,
                                      size: ButtonSize.medium,
                                      onPressed: () {
                                        setState(() {
                                          expandedSchedules[expandedSchedules
                                                  .indexWhere(
                                                    (element) =>
                                                        element.$1 == weekday,
                                                  )]
                                              .$2
                                              .remove(schedule);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                            AppTextButton(
                              text: context.strings.addNewSchedule,
                              size: ButtonSize.large,
                              color: SemanticColor.neutral,
                              onPressed: () {
                                final index = expandedSchedules.indexWhere(
                                  (element) => element.$1 == weekday,
                                );
                                final updatedSchedule = (
                                  weekday,
                                  [
                                    ...expandedSchedules[index].$2,
                                    (
                                      const TimeOfDay(hour: 0, minute: 0),
                                      const TimeOfDay(hour: 23, minute: 59),
                                    ),
                                  ],
                                );
                                setState(() {
                                  expandedSchedules = [
                                    ...expandedSchedules.take(index),
                                    updatedSchedule,
                                    ...expandedSchedules.skip(index + 1),
                                  ];
                                });
                                widget.onChanged(expandedSchedules);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

extension WeekdayX on Weekday {
  String name(BuildContext context) {
    switch (this) {
      case Weekday.monday:
        return context.strings.monday;
      case Weekday.tuesday:
        return context.strings.tuesday;
      case Weekday.wednesday:
        return context.strings.wednesday;
      case Weekday.thursday:
        return context.strings.thursday;
      case Weekday.friday:
        return context.strings.friday;
      case Weekday.saturday:
        return context.strings.saturday;
      case Weekday.sunday:
        return context.strings.sunday;
    }
  }
}
