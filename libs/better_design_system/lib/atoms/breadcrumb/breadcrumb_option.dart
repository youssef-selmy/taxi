import 'package:flutter/widgets.dart';

class BreadcrumbOption<T> {
  final String title;
  final T value;

  /// Icon to display for this breadcrumb item. Defaults to home icon; set to null to hide icon.
  final IconData? icon;

  BreadcrumbOption({required this.title, required this.value, this.icon});
}
