import 'package:flutter/cupertino.dart';

class TabMenuHorizontalOption<T> {
  final IconData? icon;
  final Widget? prefixWidget;
  final String title;
  final T value;
  final bool showArrow;
  final int? badgeNumber;
  final void Function(T value)? onPressed;

  TabMenuHorizontalOption({
    this.prefixWidget,
    required this.title,
    required this.value,
    this.showArrow = false,
    this.onPressed,
    this.badgeNumber,
    this.icon,
  }) : assert(
         !(icon != null && prefixWidget != null),
         'Only one of icon or prefixWidget can be provided, not both.',
       );
}
