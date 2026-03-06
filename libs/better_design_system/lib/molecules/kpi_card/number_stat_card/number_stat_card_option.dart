import 'dart:ui';

class NumberStatCardOption {
  final String title;
  final String? subtitle;
  final double? percent;
  final Color color;
  final double value;

  NumberStatCardOption({
    required this.title,
    this.subtitle,
    this.percent,
    required this.color,
    required this.value,
  });
}
