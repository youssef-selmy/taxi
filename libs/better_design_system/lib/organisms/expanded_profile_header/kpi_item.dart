import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';

class KpiItem {
  final String title;
  final String value;
  final IconData icon;
  final SemanticColor iconColor;

  const KpiItem({
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor = SemanticColor.primary,
  });
}
