import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/day_number/day_number.dart';
import 'package:better_design_system/atoms/time_picker_spinner/time_picker_spinner.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

enum _DatePickerType { date, month, time, year }

enum DatePickerSelectionMode { day, week, month, year, range }

typedef BetterDatePicker = AppDatePicker;

class AppDatePicker extends StatefulWidget {
  final String? title;
  final DateTime? activeDate;
  final ValueChanged<DateTime?> onChanged;
  final void Function(DateTime startDate, DateTime endDate)? onRangeChanged;
  final List<(DateTime, DateTime)>? disabledDates;
  final List<DateTime>? events;
  final bool pickTime;
  final (DateTime, DateTime)? rangeDate;
  final bool showActionButtons;

  /// If true, removes the internal horizontal paddings so the grid & headers
  /// touch the container edges (useful when used in wide/expanded layouts).
  final bool fullBleed;

  final DatePickerSelectionMode selectionMode;
  const AppDatePicker({
    super.key,
    this.activeDate,
    this.disabledDates,
    this.title,
    this.events,
    this.pickTime = false,
    this.rangeDate,
    this.onRangeChanged,
    required this.onChanged,
    this.showActionButtons = false,
    this.selectionMode = DatePickerSelectionMode.day,
    this.fullBleed = false,
  }) : assert(
         selectionMode == DatePickerSelectionMode.day || onRangeChanged != null,
         'onChangedRange must not be null when selectionMode is not day',
       );

  factory AppDatePicker.single({
    Key? key,
    String? title,
    DateTime? activeDate,
    required ValueChanged<DateTime?> onChanged,
    List<(DateTime, DateTime)>? disabledDates,
    List<DateTime>? events,
    bool pickTime = false,
    bool showActionButtons = false,
    bool fullBleed = false,
  }) {
    return AppDatePicker(
      key: key,
      title: title,
      selectionMode: DatePickerSelectionMode.day,
      activeDate: activeDate,
      onChanged: onChanged,
      onRangeChanged: null,
      disabledDates: disabledDates,
      events: events,
      pickTime: pickTime,
      showActionButtons: showActionButtons,
      fullBleed: fullBleed,
    );
  }

  factory AppDatePicker.range({
    Key? key,
    String? title,
    required DatePickerSelectionMode selectionMode,
    required void Function(DateTime start, DateTime end) onChanged,
    (DateTime, DateTime)? rangeDate,
    List<(DateTime, DateTime)>? disabledDates,
    List<DateTime>? events,
    // DateTime? activeDate,
    bool showActionButtons = false,
    bool fullBleed = false,
  }) {
    assert(
      selectionMode != DatePickerSelectionMode.day,
      'Use AppDatePicker.single for day mode',
    );

    return AppDatePicker(
      key: key,
      title: title,
      selectionMode: selectionMode,
      onChanged: (_) {},
      onRangeChanged: onChanged,
      rangeDate: rangeDate,
      disabledDates: disabledDates,
      // activeDate: activeDate,
      events: events,
      pickTime: false,
      showActionButtons: showActionButtons,
      fullBleed: fullBleed,
    );
  }

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  late DateTime activeDate;
  late DateTime displayedMonth;
  DateTime? selectedDate;
  (DateTime, DateTime)? selectedRange;
  DateTime? selectedTime;
  DateTime? _hoveredDateForWeek;

  _DatePickerType type = _DatePickerType.date;

  bool selectedWeek = false;
  bool isRangeMode = false;
  @override
  void initState() {
    super.initState();
    selectedRange = widget.rangeDate;
    activeDate = widget.selectionMode == DatePickerSelectionMode.range
        ? widget.rangeDate?.$1 ?? DateTime.now()
        : widget.activeDate ?? DateTime.now();
    displayedMonth = DateTime(activeDate.year, activeDate.month);

    switch (widget.selectionMode) {
      case DatePickerSelectionMode.day:
        type = _DatePickerType.date;
      case DatePickerSelectionMode.week:
        type = _DatePickerType.date;
        selectedWeek = true;
      case DatePickerSelectionMode.month:
        type = _DatePickerType.month;
      case DatePickerSelectionMode.year:
        type = _DatePickerType.year;
      case DatePickerSelectionMode.range:
        type = _DatePickerType.date;
        isRangeMode = true;
    }
  }

  void _changeMonth(int offset) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        displayedMonth = DateTime(
          displayedMonth.year,
          displayedMonth.month + offset,
        );
        selectedDate = displayedMonth;
      });
      if (!isRangeMode) {
        widget.onChanged(selectedDate);
      }
    });
  }

  void _changeYear(int offset) {
    final newYear = displayedMonth.year + offset;
    if (newYear >= 1970) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          displayedMonth = DateTime(newYear, displayedMonth.month);
          selectedDate = displayedMonth;
        });
        if (!isRangeMode) {
          widget.onChanged(selectedDate);
        }
      });
    }
  }

  bool _isDisabled(DateTime date) {
    if (widget.disabledDates == null) {
      final now = DateTime.now();
      final isCurrentMonth = date.year == now.year && date.month == now.month;
      final isPastMonth = date.isBefore(DateTime(now.year, now.month, 1));

      return (isCurrentMonth && date.day < now.day) || isPastMonth;
    } else {
      return widget.disabledDates!.any(
        (range) => !date.isBefore(range.$1) && !date.isAfter(range.$2),
      );
    }
  }

  List<Widget> _buildDays() {
    final firstDayOfMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      1,
    );
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = DateUtils.getDaysInMonth(
      displayedMonth.year,
      displayedMonth.month,
    );
    final previousMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month - 1,
    );
    final daysInPreviousMonth = DateUtils.getDaysInMonth(
      previousMonth.year,
      previousMonth.month,
    );
    final eventDates =
        widget.events?.map((d) => DateTime(d.year, d.month, d.day)).toSet() ??
        {};

    List<Widget> days = [];

    for (int i = firstWeekday - 1; i >= 0; i--) {
      final day = daysInPreviousMonth - i;
      days.add(AppDayNumber(title: day.toString(), isDisabled: true));
    }

    DateTime? weekStart;
    DateTime? weekEnd;
    if (selectedWeek && selectedRange != null) {
      weekStart = selectedRange!.$1;
      weekEnd = selectedRange!.$2;
    } else if (selectedWeek) {
      weekStart = activeDate;
      weekEnd = activeDate.add(const Duration(days: 6));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(displayedMonth.year, displayedMonth.month, day);

      bool isSelected = false;
      bool isActive = false;
      DayNumberType dayNumberType = DayNumberType.single;

      if (selectedWeek && weekStart != null && weekEnd != null) {
        if (!date.isBefore(weekStart) && !date.isAfter(weekEnd)) {
          if (date.isAtSameMomentAs(weekStart) ||
              date.isAtSameMomentAs(weekEnd)) {
            isActive = true;
            dayNumberType = DayNumberType.range;
          } else {
            dayNumberType = DayNumberType.range;
          }
        }
      } else {
        isSelected =
            selectedDate?.year == date.year &&
            selectedDate?.month == date.month &&
            selectedDate?.day == date.day;

        isActive =
            activeDate.year == date.year &&
            activeDate.month == date.month &&
            activeDate.day == date.day;
      }

      final hasEvent = eventDates.contains(date);

      final hoveredWeekStart = _hoveredDateForWeek;
      final hoveredWeekEnd = hoveredWeekStart?.add(const Duration(days: 6));
      final isInHoveredWeek = hoveredWeekStart != null && hoveredWeekEnd != null
          ? !date.isBefore(hoveredWeekStart) && !date.isAfter(hoveredWeekEnd)
          : false;

      final isInSelectedRange = selectedRange != null
          ? !date.isBefore(selectedRange!.$1) &&
                !date.isAfter(selectedRange!.$2)
          : false;

      if (!selectedWeek && (isRangeMode || selectedWeek)) {
        if (isInSelectedRange) {
          dayNumberType = DayNumberType.range;
        }
      }

      days.add(
        AppDayNumber(
          title: day.toString(),
          onPressed: () {
            if (selectedWeek) {
              final startOfWeek = date;
              final endOfWeek = startOfWeek.add(const Duration(days: 6));
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  selectedRange = (startOfWeek, endOfWeek);
                  selectedDate = date;
                });
                if (widget.onRangeChanged != null) {
                  widget.onRangeChanged!(selectedRange!.$1, selectedRange!.$2);
                }
                widget.onChanged(selectedDate);
              });
            } else if (isRangeMode) {
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                if (widget.pickTime) {
                  setState(() {
                    type = _DatePickerType.time;
                  });
                }
                setState(() => selectedDate = date);
                widget.onChanged(selectedDate);
              });
            }
          },
          onHover: (isHovering) {
            if (selectedWeek) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  _hoveredDateForWeek = isHovering ? date : null;
                });
              });
            }
          },
          isSelected: isSelected,
          isActive: isActive,
          isDisabled: _isDisabled(date),
          hasDot: hasEvent,
          type: isInHoveredWeek ? DayNumberType.range : dayNumberType,
          borderRadius: () {
            if (isInHoveredWeek) {
              if (date.isAtSameMomentAs(hoveredWeekStart)) {
                return const BorderRadius.horizontal(left: Radius.circular(8));
              } else if (date.isAtSameMomentAs(hoveredWeekEnd)) {
                return const BorderRadius.horizontal(right: Radius.circular(8));
              } else {
                return BorderRadius.zero;
              }
            } else if (selectedWeek && weekStart != null && weekEnd != null) {
              if (date.isAtSameMomentAs(weekStart)) {
                return const BorderRadius.horizontal(left: Radius.circular(8));
              } else if (date.isAtSameMomentAs(weekEnd)) {
                return const BorderRadius.horizontal(right: Radius.circular(8));
              } else if (!date.isBefore(weekStart) && !date.isAfter(weekEnd)) {
                return BorderRadius.zero;
              }
            } else if (isRangeMode &&
                selectedRange != null &&
                isInSelectedRange) {
              if (date.isAtSameMomentAs(selectedRange!.$1)) {
                return const BorderRadius.horizontal(left: Radius.circular(8));
              } else if (date.isAtSameMomentAs(selectedRange!.$2)) {
                return const BorderRadius.horizontal(right: Radius.circular(8));
              } else {
                return BorderRadius.zero;
              }
            }
            return const BorderRadius.all(Radius.circular(8));
          }(),
        ),
      );
    }

    int totalItems = days.length;
    int remainder = totalItems % 7;
    if (remainder != 0) {
      int nextDaysToAdd = 7 - remainder;
      for (int i = 1; i <= nextDaysToAdd; i++) {
        days.add(AppDayNumber(title: i.toString(), isDisabled: true));
      }
    }

    return days;
  }

  List<Widget> _buildMonths() {
    return List.generate(12, (index) {
      final date = DateTime(displayedMonth.year, index + 1);
      final isSelected =
          selectedDate?.year == date.year && selectedDate?.month == date.month;
      final isActive =
          activeDate.year == date.year && activeDate.month == date.month;

      return AppDayNumber(
        title: DateFormat.MMM().format(date),
        onPressed: () {
          final startOfMonth = DateTime(date.year, date.month, 1);
          final endOfMonth = DateTime(
            date.year,
            date.month,
            DateUtils.getDaysInMonth(date.year, date.month),
          );

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            if (widget.selectionMode == DatePickerSelectionMode.month) {
              setState(() {
                selectedDate = date;
                displayedMonth = date;
                selectedRange = (startOfMonth, endOfMonth);
              });

              if (widget.onRangeChanged != null) {
                widget.onRangeChanged!(selectedRange!.$1, selectedRange!.$2);
              }
              return;
            }

            setState(() {
              selectedDate = date;
              displayedMonth = date;
              type = _DatePickerType.date;
            });

            widget.onChanged(selectedDate);
          });
        },
        isSelected: isSelected,
        isActive: isActive,
      );
    });
  }

  int get startYear => (displayedMonth.year ~/ 12) * 12;
  int get endYear => startYear + 11;

  List<Widget> _buildYears() {
    final years = List.generate(12, (index) {
      final year = startYear + index;
      final isSelected = selectedDate?.year == year;
      final isActive = activeDate.year == year;

      return AppDayNumber(
        title: year.toString(),
        onPressed: () {
          final startOfYear = DateTime(year, 1, 1);
          final endOfYear = DateTime(year, 12, 31);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            if (widget.selectionMode == DatePickerSelectionMode.year) {
              setState(() {
                displayedMonth = DateTime(year);
                selectedDate = DateTime(year);
                selectedRange = (startOfYear, endOfYear);
              });

              if (widget.onRangeChanged != null) {
                widget.onRangeChanged!(selectedRange!.$1, selectedRange!.$2);
              }
              return;
            }

            setState(() {
              displayedMonth = DateTime(year);
              selectedDate = DateTime(year);
              type = _DatePickerType.month;
            });

            widget.onChanged(selectedDate);
          });
        },
        isSelected: isSelected,
        isActive: isActive,
      );
    });

    return years;
  }

  List<Widget> _buildDaysWithRange() {
    final firstDayOfMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month,
      1,
    );
    final firstWeekday = firstDayOfMonth.weekday % 7;

    final daysInMonth = DateUtils.getDaysInMonth(
      displayedMonth.year,
      displayedMonth.month,
    );

    final previousMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month - 1,
    );
    final daysInPreviousMonth = DateUtils.getDaysInMonth(
      previousMonth.year,
      previousMonth.month,
    );

    final start = selectedRange?.$1;
    final end = selectedRange?.$2;

    final eventDates =
        widget.events?.map((d) => DateTime(d.year, d.month, d.day)).toSet() ??
        {};

    List<Widget> days = [];

    for (int i = firstWeekday - 1; i >= 0; i--) {
      final day = daysInPreviousMonth - i;
      days.add(AppDayNumber(title: day.toString(), isDisabled: true));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(displayedMonth.year, displayedMonth.month, day);

      final isInRange = start != null && end != null
          ? !date.isBefore(start) && !date.isAfter(end)
          : false;

      final isSelected = start != null && end != null
          ? date.isAtSameMomentAs(start) || date.isAtSameMomentAs(end)
          : false;

      final hasEvent = eventDates.contains(date);

      BorderRadius radius = BorderRadius.circular(8);

      if (isInRange) {
        final weekdayIndex = (firstWeekday + day - 1) % 7;

        if (date.isAtSameMomentAs(start) && date.isAtSameMomentAs(end)) {
          // Single day range - full rounded corners
          radius = BorderRadius.circular(8);
        } else if (date.isAtSameMomentAs(start)) {
          // Start of range - only left rounded
          radius = const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          );
        } else if (date.isAtSameMomentAs(end)) {
          // End of range - only right rounded
          radius = const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          );
        } else if (weekdayIndex == 6) {
          // Last day of week (Saturday) - right rounded
          radius = const BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          );
        } else if (weekdayIndex == 0) {
          // First day of week (Sunday) - left rounded
          radius = const BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          );
        } else {
          // Middle of range - no rounding
          radius = BorderRadius.zero;
        }
      }

      days.add(
        AppDayNumber(
          title: day.toString(),
          isDisabled: _isDisabled(date),
          isActive: isSelected,
          hasDot: hasEvent,
          borderRadius: radius,
          type: isInRange ? DayNumberType.range : DayNumberType.single,
          onPressed: () {
            // No selection OR complete range exists OR same start/end (waiting for second date):
            // Start a new range from clicked date
            final hasCompleteRange =
                selectedRange != null &&
                !selectedRange!.$1.isAtSameMomentAs(selectedRange!.$2);
            final isWaitingForSecondDate =
                selectedRange != null &&
                selectedRange!.$1.isAtSameMomentAs(selectedRange!.$2);

            if (selectedRange == null || hasCompleteRange) {
              // Start new range
              final range = (date, date);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  selectedRange = range;
                });
                widget.onRangeChanged?.call(range.$1, range.$2);
              });
              return;
            }

            if (isWaitingForSecondDate) {
              // Complete the range with second date
              final start = selectedRange!.$1;
              final range = date.isBefore(start)
                  ? (date, start)
                  : (start, date);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  selectedRange = range;
                });
                widget.onRangeChanged?.call(range.$1, range.$2);
              });
            }
          },
        ),
      );
    }

    int totalItems = days.length;
    int remainder = totalItems % 7;
    if (remainder != 0) {
      int nextDaysToAdd = 7 - remainder;
      for (int i = 1; i <= nextDaysToAdd; i++) {
        days.add(AppDayNumber(title: i.toString(), isDisabled: true));
      }
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.fullBleed
          ? const BoxConstraints()
          : const BoxConstraints(maxWidth: 362),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          if (widget.title != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.fullBleed ? 0 : 12,
              ),
              child: Text(widget.title!, style: context.textTheme.labelLarge),
            ),
            const SizedBox(height: 12),
          ],
          if (type != _DatePickerType.time)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.fullBleed ? 0 : 12,
              ),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.colors.surfaceVariantLow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getChangeMonthButton(
                      context,
                      icon: BetterIcons.arrowLeft01Outline,
                      onPressed: () {
                        switch (type) {
                          case _DatePickerType.date:
                            _changeMonth(-1);
                          case _DatePickerType.month:
                            _changeYear(-1);
                          case _DatePickerType.year:
                            _changeYear(-10);
                          case _DatePickerType.time:
                            null;
                        }
                      },
                    ),
                    AppTextButton(
                      color: SemanticColor.neutral,
                      size: ButtonSize.medium,
                      onPressed: type == _DatePickerType.year
                          ? null
                          : () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (!mounted) return;
                                if (type == _DatePickerType.date) {
                                  setState(() {
                                    type = _DatePickerType.month;
                                  });
                                } else if (type == _DatePickerType.month) {
                                  if (widget.selectionMode ==
                                      DatePickerSelectionMode.month) {
                                    return;
                                  } else {
                                    setState(() {
                                      type = _DatePickerType.year;
                                    });
                                  }
                                }
                              });
                            },
                      text: switch (type) {
                        _DatePickerType.date => DateFormat(
                          'MMMM yyyy',
                        ).format(displayedMonth),

                        _DatePickerType.month => displayedMonth.year.toString(),

                        _DatePickerType.year => '$startYear - $endYear',

                        _DatePickerType.time => '',
                      },
                    ),

                    _getChangeMonthButton(
                      context,
                      icon: BetterIcons.arrowRight01Outline,
                      onPressed: () {
                        switch (type) {
                          case _DatePickerType.date:
                            _changeMonth(1);
                          case _DatePickerType.month:
                            _changeYear(1);
                          case _DatePickerType.year:
                            _changeYear(10);
                          case _DatePickerType.time:
                            null;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          if (type == _DatePickerType.date && isRangeMode) ...[
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.fullBleed ? 0 : 12,
              ),
              child: Row(
                spacing: 24,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Text(
                        DateFormat(
                          'MMM dd, yyyy',
                        ).format(selectedRange?.$1 ?? DateTime.now()),
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Text(
                        DateFormat(
                          'MMM dd, yyyy',
                        ).format(selectedRange?.$2 ?? DateTime.now()),
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          if (type == _DatePickerType.date && !isRangeMode) ...[
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.fullBleed ? 0 : 12,
              ),
              child: Row(
                spacing: 8,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Text(
                        DateFormat(
                          'MMM dd, yyyy',
                        ).format(selectedDate ?? activeDate),
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      final now = DateTime.now();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) return;
                        setState(() {
                          displayedMonth = DateTime(now.year, now.month);
                          selectedDate = now;
                        });
                      });
                    },
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Text(
                        'Today',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],

          if (type == _DatePickerType.date)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.fullBleed ? 0 : 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                    .map(
                      (e) => Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 11.5,
                          ),
                          color: context.colors.surface,
                          child: Center(
                            child: Text(
                              e,
                              style: context.textTheme.labelLarge?.variant(
                                context,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()
                    .separated(separator: const SizedBox(width: 4)),
              ),
            ),
          if (type == _DatePickerType.month) const SizedBox(height: 4),

          if (type != _DatePickerType.time)
            Padding(
              padding: EdgeInsets.only(
                left: widget.fullBleed ? 0 : 8,
                right: widget.fullBleed ? 0 : 8,
                bottom: widget.fullBleed ? 0 : 8,
                top: widget.fullBleed ? 0 : 4,
              ),
              child: switch (type) {
                _DatePickerType.date => GridView.count(
                  crossAxisCount: 7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: (isRangeMode || selectedWeek) ? 0 : 4,
                  mainAxisSpacing: 4,
                  children: isRangeMode ? _buildDaysWithRange() : _buildDays(),
                ),
                _DatePickerType.month => GridView.count(
                  childAspectRatio: 3,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 24,
                  children: _buildMonths(),
                ),

                _DatePickerType.year => GridView.count(
                  childAspectRatio: 3,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 24,
                  children: _buildYears(),
                ),
                _DatePickerType.time => const SizedBox(),
              },
            ),
          if (type == _DatePickerType.time)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: AppTimePickerSpinner(
                  onTimeChange: (time) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      if (!widget.showActionButtons) {
                        setState(() {
                          selectedDate = DateTime(
                            selectedDate?.year ?? activeDate.year,
                            selectedDate?.month ?? activeDate.month,
                            selectedDate?.day ?? activeDate.day,
                            time.hour,
                            time.minute,
                          );
                        });
                        widget.onChanged(selectedDate);
                        return;
                      }
                      setState(() {
                        selectedTime = time;
                      });
                    });
                  },
                ),
              ),
            ),

          if (type == _DatePickerType.time && widget.showActionButtons) ...[
            Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: context.colors.outline),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: AppOutlinedButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) return;
                          setState(() {
                            type = _DatePickerType.date;
                          });
                        });
                      },
                      text: context.strings.cancel,
                      color: SemanticColor.neutral,
                    ),
                  ),
                  Expanded(
                    child: AppFilledButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (!mounted) return;
                          setState(() {
                            selectedDate = DateTime(
                              selectedDate?.year ?? activeDate.year,
                              selectedDate?.month ?? activeDate.month,
                              selectedDate?.day ?? activeDate.day,
                              selectedTime?.hour ?? 0,
                              selectedTime?.minute ?? 0,
                            );
                            type = _DatePickerType.date;
                          });
                          widget.onChanged(selectedDate);
                        });
                      },
                      text: context.strings.confirm,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _getChangeMonthButton(
    BuildContext context, {
    required IconData icon,
    required void Function()? onPressed,
  }) {
    return AppOutlinedButton(
      onPressed: onPressed,
      prefixIcon: icon,
      color: SemanticColor.neutral,
      size: ButtonSize.medium,
    );
  }
}
