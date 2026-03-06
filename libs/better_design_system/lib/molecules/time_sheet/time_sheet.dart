import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/molecules/time_sheet/time_sheet_date_picker_overlay.dart';
import 'package:better_design_system/molecules/time_sheet/time_sheet_entry.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';

export 'time_sheet_entry.dart';

typedef BetterTimeSheet = AppTimeSheet;

class AppTimeSheet extends StatelessWidget {
  final DateTime currentStartDateTime;
  final int maxWeeklySeconds;
  final int maxDailySeconds;
  final List<TimesheetEntry> entries;
  final void Function(DateTime startDate, DateTime endDate)? onWeekChanged;
  final bool isLoading;

  const AppTimeSheet({
    super.key,
    required this.currentStartDateTime,
    required this.entries,
    required this.maxWeeklySeconds,
    required this.maxDailySeconds,
    this.onWeekChanged,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = currentStartDateTime;
    final weekDates = List.generate(7, (i) => startDate.add(Duration(days: i)));

    final maxTimeRanges = weekDates
        .map((date) {
          final entry = entries.firstWhere(
            (e) => _isSameDate(e.date, date),
            orElse: () => TimesheetEntry(date, []),
          );
          return entry.timeRanges.length;
        })
        .fold<int>(0, (prev, len) => len > prev ? len : prev);

    List<TableRow> rows = [];

    rows.add(
      TableRow(
        children: weekDates.map((date) {
          final entry = entries.firstWhere(
            (e) => _isSameDate(e.date, date),
            orElse: () => TimesheetEntry(date, []),
          );
          final total = _calculateTotalDuration(entry.timeRanges);
          final label =
              '${_weekDayName(date.weekday)}, ${date.day} ${_monthName(date.month)}';
          return _buildWeekDayCell(label, total, context);
        }).toList(),
      ),
    );

    for (int rowIndex = 0; rowIndex < maxTimeRanges; rowIndex++) {
      rows.add(
        TableRow(
          children: weekDates.map((date) {
            final entry = entries.firstWhere(
              (e) => _isSameDate(e.date, date),
              orElse: () => TimesheetEntry(date, []),
            );

            if (entry.timeRanges.length > rowIndex) {
              final tr = entry.timeRanges[rowIndex];
              return _buildTimeRangeCell(tr, context);
            } else if (rowIndex == 0 && entry.timeRanges.isEmpty) {
              return _buildDashCell(context);
            } else {
              return _buildEmptyCell(context);
            }
          }).toList(),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: <Widget>[
            AppIconButton(
              icon: BetterIcons.arrowLeft01Outline,
              size: ButtonSize.small,
              onPressed: () {
                if (onWeekChanged != null) {
                  onWeekChanged!(previousWeekDate, nextWeekDate);
                }
              },
            ),
            const SizedBox(width: 8),
            AppIconButton(
              icon: BetterIcons.arrowRight01Outline,
              size: ButtonSize.small,
              onPressed: () {
                if (onWeekChanged != null) {
                  onWeekChanged!(
                    nextWeekDate,
                    nextWeekDate.add(const Duration(days: 6)),
                  );
                }
              },
            ),
            const SizedBox(width: 10),
            TimeSheetDatePickerOverlay(
              title:
                  '${startDate.day} ${_monthName(startDate.month)} - ${weekDates.last.day} ${_monthName(weekDates.last.month)}',
              onConfirmed: (start, end) {
                onWeekChanged?.call(start, end);
              },
              activeWeek: (startDate, startDate.add(const Duration(days: 6))),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _timesheetSummaryBar(context, weekDates),
        const SizedBox(height: 11),
        Skeletonizer(
          enabled: isLoading,
          enableSwitchAnimation: true,
          child: Table(
            border: TableBorder.all(
              color: context.colors.outline,
              width: 1,
              borderRadius: BorderRadius.circular(8),
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: rows,
          ),
        ),
      ],
    );
  }

  DateTime get previousWeekDate =>
      currentStartDateTime.subtract(const Duration(days: 7));
  DateTime get nextWeekDate =>
      currentStartDateTime.add(const Duration(days: 7));

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Duration _calculateTotalDuration(List<TimeRange> ranges) {
    return ranges.fold(Duration.zero, (sum, tr) {
      final startMinutes = tr.start.hour * 60 + tr.start.minute;
      final endMinutes = (tr.end != null)
          ? (tr.end!.hour * 60 + tr.end!.minute)
          : 0;
      final diff = (endMinutes) - startMinutes;
      return sum + Duration(minutes: diff);
    });
  }

  Widget _buildWeekDayCell(
    String label,
    Duration totalDuration,
    BuildContext context,
  ) {
    final hours = totalDuration.inHours;
    final minutes = totalDuration.inMinutes.remainder(60);
    final hoursStr = hours == 0 ? '0' : hours.toString().padLeft(2, '0');
    final minutesStr = minutes == 0 ? '0' : minutes.toString().padLeft(2, '0');
    final currentDaySeconds = totalDuration.inSeconds;
    final progress = maxDailySeconds == 0
        ? 0.0
        : (currentDaySeconds / maxDailySeconds).clamp(0.0, 1.0);

    LinearProgressBarStatus getProgressColor() {
      if (progress < 0.8) {
        return LinearProgressBarStatus.uploading;
      } else if (progress < 1.0) {
        return LinearProgressBarStatus.pending;
      } else {
        return LinearProgressBarStatus.error;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          bottom: BorderSide(color: context.colors.outline, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.textTheme.bodySmall?.variant(context)),
          const SizedBox(height: 8),
          Text(
            '${hoursStr}h ${minutesStr}m',
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          if (isLoading)
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colors.surfaceVariant,
                borderRadius: BorderRadius.circular(100),
              ),
            )
          else
            AppLinearProgressBar(
              linearProgressBarStatus: getProgressColor(),
              progress: progress,
            ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeCell(TimeRange tr, BuildContext context) {
    final duration = tr.end != null
        ? (tr.end!.hour * 60 + tr.end!.minute) -
              (tr.start.hour * 60 + tr.start.minute)
        : 0;
    final totalDuration = Duration(minutes: duration);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _formatDuration(totalDuration),
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${_formatTimeOfDay(tr.start)} - ${tr.end != null ? _formatTimeOfDay(tr.end!) : '-'}',
            style: context.textTheme.labelSmall?.variant(context),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final hoursStr = hours == 0 ? '0' : hours.toString().padLeft(2, '0');
    final minutesStr = minutes == 0 ? '0' : minutes.toString().padLeft(2, '0');
    return '${hoursStr}h ${minutesStr}m';
  }

  String _formatTimeOfDay(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'am' : 'pm';
    return '$hour:$minute $period';
  }

  Widget _buildDashCell(BuildContext context) => _buildEmptyCell(context);

  Widget _buildEmptyCell(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      alignment: Alignment.centerRight,
      child: Text('-', style: context.textTheme.bodyLarge?.variant(context)),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }

  String _weekDayName(int weekday) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days[weekday % 7];
  }

  Widget _timesheetSummaryBar(BuildContext context, List<DateTime> weekDates) {
    final totalWeeklyDuration = weekDates.fold(Duration.zero, (sum, date) {
      final entry = entries.firstWhere(
        (e) => _isSameDate(e.date, date),
        orElse: () => TimesheetEntry(date, []),
      );
      return sum + _calculateTotalDuration(entry.timeRanges);
    });

    final totalWorkedSeconds = totalWeeklyDuration.inSeconds;
    final progress = maxWeeklySeconds == 0
        ? 0.0
        : totalWorkedSeconds / maxWeeklySeconds;
    final statusCounts = _calculateMonthlyStatusCounts();
    final totalDays = statusCounts.values.fold(0, (a, b) => a + b);

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline, width: 1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Weekly Time Sheet Summary",
                style: context.textTheme.bodyMedium?.variant(context),
              ),
              const SizedBox(height: 8),
              Skeletonizer(
                enabled: isLoading,
                enableSwitchAnimation: true,
                child: Row(
                  children: [
                    Container(
                      width: 170,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: context.colors.outline,
                      ),
                      child: isLoading
                          ? null
                          : FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress.clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.warning,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _formatDuration(Duration(seconds: maxWeeklySeconds)),
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Container(width: 1, color: context.colors.outline, height: 75),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Time Sheet Summary",
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
                const SizedBox(height: 16),
                _buildSegment(
                  context,
                  lowProgress:
                      statusCounts[LinearProgressBarStatus.uploading]! /
                      totalDays,
                  mediumProgress:
                      statusCounts[LinearProgressBarStatus.pending]! /
                      totalDays,
                  highProgress:
                      statusCounts[LinearProgressBarStatus.error]! / totalDays,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total for ',
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    TextSpan(
                      text: _monthName(currentStartDateTime.month),
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Skeletonizer(
                enabled: isLoading,
                enableSwitchAnimation: true,
                child: Text(
                  _formatDuration(_calculateTotalDurationForMonth()),
                  style: context.textTheme.labelMedium,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Duration _calculateTotalDurationForMonth() {
    final monthEntries = entries.where(
      (e) =>
          e.date.year == currentStartDateTime.year &&
          e.date.month == currentStartDateTime.month,
    );
    return monthEntries.fold(Duration.zero, (sum, entry) {
      return sum + _calculateTotalDuration(entry.timeRanges);
    });
  }

  Map<LinearProgressBarStatus, int> _calculateMonthlyStatusCounts() {
    final monthEntries = entries.where(
      (e) =>
          e.date.year == currentStartDateTime.year &&
          e.date.month == currentStartDateTime.month,
    );
    final counts = <LinearProgressBarStatus, int>{
      LinearProgressBarStatus.uploading: 0,
      LinearProgressBarStatus.pending: 0,
      LinearProgressBarStatus.error: 0,
    };

    for (final entry in monthEntries) {
      final total = _calculateTotalDuration(entry.timeRanges).inSeconds;
      final progress = maxDailySeconds == 0 ? 0.0 : total / maxDailySeconds;

      if (progress < 0.8) {
        counts[LinearProgressBarStatus.uploading] =
            counts[LinearProgressBarStatus.uploading]! + 1;
      } else if (progress < 1.0) {
        counts[LinearProgressBarStatus.pending] =
            counts[LinearProgressBarStatus.pending]! + 1;
      } else {
        counts[LinearProgressBarStatus.error] =
            counts[LinearProgressBarStatus.error]! + 1;
      }
    }

    return counts;
  }

  Widget _buildSegment(
    BuildContext context, {
    required double lowProgress,
    required double mediumProgress,
    required double highProgress,
  }) {
    if (isLoading) {
      return Skeletonizer(
        enabled: true,
        enableSwitchAnimation: true,
        child: Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.surfaceVariant,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    }
    return Row(
      children: [
        if (lowProgress > 0)
          Expanded(
            flex: (lowProgress * 1000).round(),
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(100),
                  bottomLeft: const Radius.circular(100),
                  topRight: Radius.circular(
                    (mediumProgress == 0 && highProgress == 0) ? 100 : 0,
                  ),
                  bottomRight: Radius.circular(
                    (mediumProgress == 0 && highProgress == 0) ? 100 : 0,
                  ),
                ),
              ),
            ),
          ),
        if (mediumProgress > 0)
          Expanded(
            flex: (mediumProgress * 1000).round(),
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: context.colors.warning,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(lowProgress == 0 ? 100 : 0),
                  bottomLeft: Radius.circular(lowProgress == 0 ? 100 : 0),
                  topRight: Radius.circular((highProgress == 0) ? 100 : 0),
                  bottomRight: Radius.circular((highProgress == 0) ? 100 : 0),
                ),
              ),
            ),
          ),
        if (highProgress > 0)
          Expanded(
            flex: (highProgress * 1000).round(),
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: context.colors.error,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    (lowProgress == 0 && mediumProgress == 0) ? 100 : 0,
                  ),
                  bottomLeft: Radius.circular(
                    (lowProgress == 0 && mediumProgress == 0) ? 100 : 0,
                  ),
                  topRight: const Radius.circular(100),
                  bottomRight: const Radius.circular(100),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
