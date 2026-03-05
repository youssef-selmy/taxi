import 'package:flutter/material.dart';

class ChartSeriesData<T> {
  final String name;
  final double value;
  final Color? color;
  final T? groupBy;

  ChartSeriesData({
    required this.name,
    required this.value,
    this.color,
    this.groupBy,
  });
}
