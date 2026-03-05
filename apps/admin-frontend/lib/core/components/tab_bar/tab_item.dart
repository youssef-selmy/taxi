import 'package:flutter/material.dart';

class AppTabItem {
  final String title;
  final IconData? iconUnselected;
  final IconData? iconSelected;
  final int? badgeCount;

  const AppTabItem({
    required this.title,
    this.iconUnselected,
    this.iconSelected,
    this.badgeCount,
  });
}
