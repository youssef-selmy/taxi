import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/cupertino.dart';

class NavigationTabItem<T> {
  final String title;
  final IconData icon;
  final SemanticColor color;
  final AppBadge? badge;
  final T value;
  final Widget? child;

  const NavigationTabItem({
    required this.title,
    required this.icon,
    this.color = SemanticColor.primary,
    this.badge,
    required this.value,
    this.child,
  });
}
