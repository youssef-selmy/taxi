import 'package:flutter/material.dart';

typedef BetterMinMax = AppMinMax;

class AppMinMax extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final TextStyle textStyle;
  final String Function(double value, {bool forMinMax}) valueFormatter;
  final double? width;
  final int? intermediateStepsCount;

  const AppMinMax({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.textStyle,
    required this.valueFormatter,
    this.width,
    this.intermediateStepsCount,
  }) : assert(intermediateStepsCount == null || intermediateStepsCount >= 0);

  List<double> _ticks() {
    final ticks = <double>[minValue];
    final range = maxValue - minValue;
    final steps = (intermediateStepsCount ?? 0);
    if (steps > 0 && range > 0) {
      for (var i = 1; i <= steps; i++) {
        ticks.add(minValue + range * (i / (steps + 1)));
      }
    }
    ticks.add(maxValue);
    return ticks;
  }

  double _percent(double v) {
    final range = maxValue - minValue;
    if (range <= 0) return 0;
    return ((v - minValue) / range).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final labels = _ticks();

    return SizedBox(
      width: width,
      height: 25,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < labels.length; i++)
            Align(
              alignment: Alignment(_percent(labels[i]) * 2 - 1, 0),
              child: Text(
                valueFormatter(
                  labels[i],
                  forMinMax: i == 0 || i == labels.length - 1,
                ),
                style: textStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                softWrap: false,
              ),
            ),
        ],
      ),
    );
  }
}
