import 'package:flutter/widgets.dart';

class GroupItemStatCardOption {
  final String title;
  final double percent;
  final Color color;
  final IconData? icon;

  GroupItemStatCardOption(
    this.color, {
    required this.title,
    required this.percent,
    this.icon,
  });
}
