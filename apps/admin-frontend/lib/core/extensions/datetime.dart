part of 'extensions.dart';

extension DateTimeX on DateTime {
  String get toTimeAgo => timeago.format(this);

  DateTime get startOfThisMonth => DateTime(year, month, 1);

  DateTime get startOfPreviousMonth {
    if (month == 1) {
      return DateTime(year - 1, 12, 1);
    } else {
      return DateTime(year, month - 1, 1);
    }
  }

  (DateTime, DateTime) get currentMonthRange =>
      (startOfThisMonth, DateTime.now());

  (DateTime, DateTime) get samePeriodAsThisMonthForLastMonth {
    final now = DateTime.now();
    return (startOfPreviousMonth, now.subtract(const Duration(days: 30)));
  }

  DateTime get endOfThisMonth {
    if (month == 12) {
      return DateTime(year + 1, 1, 1);
    } else {
      return DateTime(year, month + 1, 1);
    }
  }

  DateTime get startOfThisWeek {
    final day = weekday;
    return subtract(Duration(days: day - 1));
  }

  DateTime get startOfPreviousWeek {
    final day = weekday;
    return subtract(Duration(days: day + 6));
  }

  (DateTime, DateTime) get currentWeekRange =>
      (startOfThisWeek, DateTime.now());

  (DateTime, DateTime) get samePeriodAsThisWeekForLastWeek {
    final now = DateTime.now();
    return (startOfPreviousWeek, now.subtract(const Duration(days: 7)));
  }

  DateTime get endOfThisWeek {
    final day = weekday;
    return add(Duration(days: 7 - day));
  }

  DateTime get endOfPreviousWeek {
    final day = weekday;
    return subtract(Duration(days: day));
  }

  DateTime get startOfQuarter {
    final quarter = ((month - 1) / 3).ceil();
    return DateTime(year, 3 * quarter - 2, 1);
  }

  DateTime get endOfQuarter {
    final quarter = ((month - 1) / 3).ceil();
    return DateTime(year, 3 * quarter + 1, 1);
  }

  DateTime get startOfPreviousQuarter {
    final quarter = ((month - 1) / 3).ceil();
    return DateTime(year, 3 * quarter - 5, 1);
  }

  (DateTime, DateTime) get currentQuarterRange =>
      (startOfQuarter, DateTime.now());

  (DateTime, DateTime) get samePeriodAsThisQuarterForLastQuarter {
    final now = DateTime.now();
    return (startOfPreviousQuarter, now.subtract(const Duration(days: 90)));
  }

  DateTime get endOfPreviousQuarter {
    final quarter = ((month - 1) / 3).ceil();
    return DateTime(year, 3 * quarter - 2, 1);
  }

  DateTime get startOfYear => DateTime(year, 1, 1);

  DateTime get endOfYear => DateTime(year + 1, 1, 1);

  DateTime get startOfPreviousYear => DateTime(year - 1, 1, 1);

  DateTime get endOfPreviousYear => DateTime(year, 1, 1);

  (DateTime, DateTime) get currentYearRange => (startOfYear, DateTime.now());

  (DateTime, DateTime) get samePeriodAsThisYearForLastYear {
    final now = DateTime.now();
    return (startOfPreviousYear, now.subtract(const Duration(days: 365)));
  }
}

extension TimeOfDayX on TimeOfDay {
  String format(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(this);
  }
}
