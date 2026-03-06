import 'dart:math';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

class AppHalfArcChart extends StatelessWidget {
  final String mainText;
  final String subText;

  const AppHalfArcChart({
    super.key,

    required this.mainText,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          height: 112,
          child: CustomPaint(
            painter: _HalfArcChartPainter(
              angle: pi * (50) / 100,
              activeColor: context.colors.primary,
              inactiveColor: context.colors.surfaceVariant,
              underColor: context.colors.warning,
            ),

            child: Column(
              children: [
                SizedBox(height: 55),
                Text(mainText, style: context.textTheme.titleMedium),
                SizedBox(height: 4),
                Text(
                  subText,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HalfArcChartPainter extends CustomPainter {
  final double angle;
  final Color activeColor;
  final Color inactiveColor;
  final Color underColor;

  _HalfArcChartPainter({
    required this.angle,
    required this.activeColor,
    required this.inactiveColor,
    required this.underColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final bgPaint =
        Paint()
          ..strokeWidth = 30
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..color = inactiveColor;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      bgPaint,
    );

    final underPaint =
        Paint()
          ..strokeWidth = 30
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..color = underColor;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi * 0.85,
      false,
      underPaint,
    );

    if (0.85 > 0) {
      final endAngle = pi + pi * 0.85;
      final underDotPaint =
          Paint()
            ..strokeWidth = 30
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round
            ..color = underColor;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        endAngle - 0.02,
        0.02,
        false,
        underDotPaint,
      );
    }

    final activePaint =
        Paint()
          ..strokeWidth = 30
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt
          ..color = activeColor;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      angle,
      false,
      activePaint,
    );
    if (angle > 0) {
      final endAngle = pi + angle;
      final dotPaint =
          Paint()
            ..strokeWidth = 30
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round
            ..color = activeColor;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        endAngle - 0.02,
        0.02,
        false,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HalfArcChartPainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.underColor != underColor;
  }
}
