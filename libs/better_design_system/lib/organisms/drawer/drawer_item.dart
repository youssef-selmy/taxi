import 'package:flutter/material.dart';

typedef BetterDrawerItem = AppDrawerItem;

class AppDrawerItem<T> {
  final String title;
  final IconData icon;
  final T value;

  const AppDrawerItem({
    required this.title,
    required this.icon,
    required this.value,
  });
}
