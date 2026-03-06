part of 'extensions.dart';

extension DateTimeXX on DateTime {
  bool isSameDate(DateTime to) =>
      year == to.year && month == to.month && day == to.day;

  String minutesFromNow(BuildContext context) {
    final diff = difference(DateTime.now());
    if (diff.isNegative) {
      return context.strings.timePastDue;
    } else if (diff.inMinutes < 1) {
      return context.strings.justNow;
    } else {
      return context.strings.durationInMinutes(diff.inMinutes);
    }
  }

  bool get isToday => isSameDate(DateTime.now());

  // String get _formatTimeAmPm => DateFormat('hh:mm a').format(this);

  String get _formatTime24Hours => DateFormat('HH:mm').format(this);

  // String get _formatDateTimeAmPm => DateFormat('dd MMM hh:mm a').format(this);

  String get _formatDateTime24Hours =>
      DateFormat('dd MMM yyyy HH:mm').format(this);

  String get formatTime => _formatTime24Hours;
  // Constants.showTimeIn24HourFormat ? _formatTime24Hours : _formatTimeAmPm;

  String get formatDateTime => _formatDateTime24Hours;
  // Constants.showTimeIn24HourFormat
  //     ? _formatDateTime24Hours
  //     : _formatDateTimeAmPm;

  String formatDate(BuildContext context) {
    if (isToday) {
      return context.strings.today;
    }
    if (isSameDate(DateTime.now().subtract(const Duration(days: 1)))) {
      return context.strings.yesterday;
    }
    return DateFormat('dd MMM').format(this);
  }

  String formatDatePlain(BuildContext context) {
    return DateFormat('dd MMM').format(this);
  }
}

extension Translator on BuildContext {
  String convertSecondsToHumanReadable(int seconds) {
    if (seconds / 3600 >= 1) {
      return '${(seconds / 3600).floor()}h';
    } else if (seconds / 60 >= 1) {
      return '${(seconds / 60).floor()}m';
    } else {
      return '${seconds.floor()}s';
    }
  }
}
