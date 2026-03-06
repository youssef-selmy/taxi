import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterHorizontalDatePicker = AppHorizontalDatePicker;

class AppHorizontalDatePicker extends StatefulWidget {
  const AppHorizontalDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime selectedDate;
  final void Function(DateTime date) onDateSelected;

  @override
  State<AppHorizontalDatePicker> createState() =>
      _AppHorizontalDatePickerState();
}

class _AppHorizontalDatePickerState extends State<AppHorizontalDatePicker> {
  final List<String> _weekdays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    final year = widget.selectedDate.year;
    final month = widget.selectedDate.month;
    final daysInMonth = DateTime(year, month + 1, 0).day;

    final monthDates = List.generate(
      daysInMonth,
      (i) => DateTime(year, month, i + 1),
    );
    final selectedIndex = widget.selectedDate.day - 1;

    int startIndex = selectedIndex - 3;
    int endIndex = selectedIndex + 3;

    if (startIndex < 0) {
      endIndex += -startIndex;
      startIndex = 0;
    }

    if (endIndex > daysInMonth - 1) {
      final overflow = endIndex - (daysInMonth - 1);
      startIndex = (startIndex - overflow).clamp(0, daysInMonth - 1);
      endIndex = daysInMonth - 1;
    }

    final coreDates = monthDates.sublist(startIndex, endIndex + 1);
    final beforeDate = startIndex > 0 ? monthDates[startIndex - 1] : null;
    final afterDate = endIndex < daysInMonth - 1
        ? monthDates[endIndex + 1]
        : null;

    final displayDates = [
      if (beforeDate != null) beforeDate,
      ...coreDates,
      if (afterDate != null) afterDate,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: displayDates
            .map((date) => _buildDateItem(context, date, beforeDate, afterDate))
            .toList()
            .separated(separator: const SizedBox(width: 8)),
      ),
    );
  }

  Widget _buildDateItem(
    BuildContext context,
    DateTime date,
    DateTime? before,
    DateTime? after,
  ) {
    final isSelected = _isSameDate(date, widget.selectedDate);
    final isToday = _isSameDate(date, DateTime.now());
    final isDimmed = date == before || date == after;

    final bgColor = isSelected || (isToday && isSelected)
        ? context.colors.tertiary
        : context.colors.transparent;
    final textColor = isSelected || (isToday && isSelected)
        ? context.colors.surface
        : context.colors.onSurfaceVariant;

    return Opacity(
      opacity: isDimmed ? 0.4 : 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => widget.onDateSelected(date),
        child: Container(
          width: 40,
          height: 64,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _weekdays[date.weekday % 7],
                style: context.textTheme.bodySmall?.copyWith(color: textColor),
              ),
              Text(
                date.day.toString(),
                style: context.textTheme.labelMedium?.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
