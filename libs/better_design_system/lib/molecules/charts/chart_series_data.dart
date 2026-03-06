import 'dart:ui';

class ChartSeriesData {
  final String name;
  final Color color;
  final List<ChartPoint> points;
  final bool isCurved;

  ChartSeriesData({
    required this.points,
    required this.name,
    required this.color,
    this.isCurved = false,
  });
}

class ChartPoint {
  final String name;
  final double value;
  ChartPoint({required this.name, required this.value});
}
