import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';

enum KColumnHeaderStyle { contained, detached }

class KColumnHeader {
  final String title;
  final IconData? icon;
  final Widget? prefix;
  final List<Widget>? trailing;
  final KColumnHeaderStyle style;
  final SemanticColor? color; // Only for detached style

  KColumnHeader({
    required this.title,
    this.icon,
    this.prefix,
    this.trailing,
    this.style = KColumnHeaderStyle.contained,
    this.color,
  });
}
