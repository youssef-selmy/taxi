import 'package:flutter/material.dart';

class StepIndicatorItem<T> {
  final IconData? icon;
  final String label;
  final String? description;
  final T value;

  StepIndicatorItem({
    this.icon,
    required this.label,
    this.description,
    required this.value,
  });
}
