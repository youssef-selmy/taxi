import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';

typedef BetterDropdownItem = AppDropdownItem;

class AppDropdownItem<T> {
  final String title;
  final T value;
  final String? subtitle;
  final String? sublabel;
  final Widget? prefix;
  final List<Widget> suffix;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool showCheckbox;
  final bool showRadio;
  final bool showArrow;
  final bool isDisabled;
  final SemanticColor color;

  AppDropdownItem({
    required this.title,
    required this.value,
    this.subtitle,
    this.prefix,
    this.suffix = const [],
    this.prefixIcon,
    this.suffixIcon,
    this.sublabel,
    this.showCheckbox = false,
    this.showRadio = false,
    this.showArrow = false,
    this.isDisabled = false,
    this.color = SemanticColor.neutral,
  });
}
