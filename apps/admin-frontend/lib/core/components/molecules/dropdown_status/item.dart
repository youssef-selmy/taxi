import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';

class DropDownStatusItem<T> {
  final T value;
  final String text;
  final SemanticColor chipType;
  final IconData? icon;

  DropDownStatusItem({
    required this.value,
    required this.text,
    required this.chipType,
    this.icon,
  });
}
