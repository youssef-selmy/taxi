import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_section.dart';
import 'package:flutter/material.dart';

typedef NavigationIcon = (IconData, IconData)?;

class NavigationItem<T> {
  final String title;
  final NavigationIcon icon;
  final T value;
  final String? badgeTitle;
  final int? badgeNumber;
  final List<NavigationSubItem<T>> subItems;
  final bool hasDot;
  final SidebarNavigationSection? section;

  NavigationItem({
    required this.title,
    required this.value,
    this.icon,
    this.badgeTitle,
    this.badgeNumber,
    this.hasDot = false,
    this.subItems = const [],
    this.section,
  });
}

class NavigationSubItem<T> {
  final String title;
  final String? badgeTitle;
  final int? badgeNumber;
  final bool hasDot;
  final T value;

  NavigationSubItem({
    required this.title,
    required this.value,
    this.badgeTitle,
    this.badgeNumber,
    this.hasDot = false,
  });
}
