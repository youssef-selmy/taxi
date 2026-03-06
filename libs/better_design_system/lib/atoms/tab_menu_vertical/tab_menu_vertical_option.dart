import 'package:flutter/material.dart';

class TabMenuVerticalOption<T> {
  final IconData icon;
  final String title;
  final T value;

  final int? badgeNumber;

  TabMenuVerticalOption({
    required this.icon,
    required this.title,
    required this.value,
    this.badgeNumber,
  });
}
