part of 'extensions.dart';

extension DoubleX on double {
  String formatCurrency(String currency) =>
      NumberFormat.simpleCurrency(name: currency).format(this);

  String formatCompactCurrency(String currency) {
    return NumberFormat.compactSimpleCurrency(name: currency).format(this);
  }
}

extension DateTimeX on DateTime {
  String format(String pattern) => DateFormat(pattern).format(this);
}
