import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';

typedef BetterPopupMenuItem = AppPopupMenuItem;

class AppPopupMenuItem {
  final String title;
  final Widget? prefix;
  final IconData? icon;
  final SemanticColor? color;
  final Function onPressed;
  final bool hasDivider;

  AppPopupMenuItem({
    required this.title,
    required this.onPressed,
    this.prefix,
    this.icon,
    this.color,
    this.hasDivider = false,
  });
}
