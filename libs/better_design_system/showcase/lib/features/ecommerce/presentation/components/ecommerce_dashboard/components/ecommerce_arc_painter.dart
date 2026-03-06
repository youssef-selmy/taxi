import 'dart:math' as math;
import 'package:flutter/material.dart';

class EcommerceArcPainter extends CustomPainter {
  final double progress; // The percentage of the circle to fill (0.0 to 1.0)
  final Color color;
  final double strokeWidth;

  EcommerceArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Configure the Paint object for drawing the arc
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style =
              PaintingStyle
                  .stroke // Draw a line, not a filled shape
          ..strokeCap = StrokeCap.round; // Make the ends rounded

    // Define the drawing area
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Define the arc's angles
    const startAngle = -math.pi / 2; // Start from the top (12 o'clock)
    final sweepAngle = 2 * math.pi * progress; // The length of the arc

    // Draw the arc on the canvas
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever properties change
  }
}
