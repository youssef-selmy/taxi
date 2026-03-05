import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class DeltaText extends StatelessWidget {
  final DetailTimePeriod timePeriod;
  final num previousValue;
  final num currentValue;
  final String? currency;

  const DeltaText({
    super.key,
    required this.timePeriod,
    required this.previousValue,
    required this.currentValue,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '%$differenceInPercentage ',
            style: context.textTheme.labelMedium?.apply(
              color: differenceColor(context),
            ),
          ),
          TextSpan(
            text: deltaText(context),
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ],
      ),
    );
  }

  String get differenceInPercentage {
    if (currentValue == 0 || previousValue == 0) {
      return "0";
    }
    final difference = currentValue - previousValue;
    final percentage = (difference / previousValue) * 100;
    // if has decimal, show 1 decimal else show 0 decimal
    return percentage.toStringAsFixed(percentage % 1 == 0 ? 0 : 1);
  }

  Color differenceColor(BuildContext context) => currentValue > previousValue
      ? (context.colors.success)
      : (context.colors.error);

  String deltaText(BuildContext context) {
    switch (timePeriod) {
      case DetailTimePeriod.today:
        return "$differenceText ${context.tr.today}";
      case DetailTimePeriod.vsLastWeek:
        return context.tr.vsLastWeek;
      case DetailTimePeriod.vsLastMonth:
        return context.tr.vsLastMonth;
      case DetailTimePeriod.vsLastQuarter:
        return context.tr.vsLastQuarter;
      case DetailTimePeriod.vsLastYear:
        return context.tr.vsLastYear;
    }
  }

  String get differenceText {
    if (currency != null) {
      return (currentValue - previousValue).toDouble().formatCompactCurrency(
        currency!,
      );
    } else {
      return (currentValue - previousValue).toString();
    }
  }
}

enum DetailTimePeriod {
  today,
  vsLastWeek,
  vsLastMonth,
  vsLastQuarter,
  vsLastYear,
}
