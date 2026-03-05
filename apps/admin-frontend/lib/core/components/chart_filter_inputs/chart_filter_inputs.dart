import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';

import 'package:admin_frontend/core/entities/chart_filter_input.extensions.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ChartFilterInputs extends StatefulWidget {
  final Input$ChartFilterInput? defaultValue;
  final void Function(Input$ChartFilterInput)? onChanged;

  const ChartFilterInputs({super.key, this.onChanged, this.defaultValue});

  @override
  State<ChartFilterInputs> createState() => _ChartFilterInputsState();
}

class _ChartFilterInputsState extends State<ChartFilterInputs> {
  late Enum$ChartInterval interval;
  late (DateTime, DateTime)? dateRange;
  late List<(DateTime, DateTime)> dateRanges;

  @override
  void initState() {
    interval = widget.defaultValue?.interval ?? Enum$ChartInterval.Yearly;
    dateRanges = _getIntervalsForDateRange(interval);

    if (widget.defaultValue?.startDate != null &&
        widget.defaultValue?.endDate != null) {
      dateRange = (
        widget.defaultValue!.startDate,
        widget.defaultValue!.endDate,
      );
    } else {
      dateRange = dateRanges[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppDropdownField.single(
          width: 130,
          hint: titleForInterval(interval),
          initialValue: dateRange,
          isFilled: false,
          type: DropdownFieldType.compact,
          onChanged: (range) {
            if (range == null) return;
            setState(() {
              dateRange = range;
              widget.onChanged?.call(
                Input$ChartFilterInput(
                  interval: interval,
                  startDate: dateRange!.$1,
                  endDate: dateRange!.$2,
                ),
              );
            });
          },
          items: dateRanges.map((e) {
            return AppDropdownItem(title: interval.format(e.$1), value: e);
          }).toList(),
        ),
        const SizedBox(width: 16),
        AppDropdownField.single(
          width: 100,
          initialValue: interval,
          hint: context.tr.interval,
          isFilled: false,
          type: DropdownFieldType.compact,
          onChanged: (inteval) {
            if (inteval == null) return;
            setState(() {
              interval = inteval;
              dateRanges = _getIntervalsForDateRange(interval);
              // delay
              dateRange = dateRanges[0];

              widget.onChanged?.call(
                Input$ChartFilterInput(
                  interval: interval,
                  startDate: dateRange!.$1,
                  endDate: dateRange!.$2,
                ),
              );
            });
          },
          items: [
            AppDropdownItem(
              title: context.tr.daily,
              value: Enum$ChartInterval.Daily,
            ),
            AppDropdownItem(
              title: context.tr.monthly,
              value: Enum$ChartInterval.Monthly,
            ),
            AppDropdownItem(
              title: context.tr.quarterly,
              value: Enum$ChartInterval.Quarterly,
            ),
            AppDropdownItem(
              title: context.tr.yearly,
              value: Enum$ChartInterval.Yearly,
            ),
          ],
        ),
      ],
    );
  }

  List<(DateTime, DateTime)> _getIntervalsForDateRange(
    Enum$ChartInterval interval,
  ) {
    final now = DateTime.now();
    switch (interval) {
      case Enum$ChartInterval.Daily:
        final intervals = <(DateTime, DateTime)>[];
        intervals.add((DateTime(now.year, now.month, now.day), now));
        for (int i = 1; i <= 30; i++) {
          intervals.add((
            DateTime(now.year, now.month, now.day).subtract(Duration(days: i)),
            DateTime(
              now.year,
              now.month,
              now.day,
            ).subtract(Duration(days: i - 1)),
          ));
        }
        return intervals;

      case Enum$ChartInterval.Monthly:
        final intervals = <(DateTime, DateTime)>[];
        intervals.add((DateTime(now.year, now.month, 1), now));
        for (int i = 1; i <= 12; i++) {
          intervals.add((
            DateTime(now.year, now.month - i, 1),
            DateTime(now.year, now.month - i + 1, 1),
          ));
        }
        return intervals;

      case Enum$ChartInterval.Quarterly:
        final intervals = <(DateTime, DateTime)>[];
        intervals.add((
          DateTime(now.year, now.month - (now.month % 3), 1),
          now,
        ));
        for (int i = 1; i <= 4; i++) {
          intervals.add((
            DateTime(now.year, now.month - i * 3, 1),
            DateTime(now.year, now.month - (i - 1) * 3, 1),
          ));
        }
        return intervals;

      case Enum$ChartInterval.Yearly:
        final intervals = <(DateTime, DateTime)>[];
        intervals.add((DateTime(now.year, 1, 1), now));
        for (int i = 1; i <= 5; i++) {
          intervals.add((
            DateTime(now.year - i, 1, 1),
            DateTime(now.year - i + 1, 1, 1),
          ));
        }
        return intervals;

      case Enum$ChartInterval.$unknown:
        throw Exception("Unknown interval");
    }
  }

  String titleForInterval(Enum$ChartInterval interval) {
    switch (interval) {
      case Enum$ChartInterval.Daily:
        return "Day";
      case Enum$ChartInterval.Monthly:
        return "Month";
      case Enum$ChartInterval.Quarterly:
        return "Quarter";
      case Enum$ChartInterval.Yearly:
        return "Year";
      case Enum$ChartInterval.$unknown:
        return "";
    }
  }
}
