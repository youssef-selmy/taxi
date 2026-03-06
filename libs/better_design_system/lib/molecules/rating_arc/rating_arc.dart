import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:gauge_indicator/gauge_indicator.dart';

typedef BetterRatingArc = AppRatingArc;

class AppRatingArc extends StatelessWidget {
  final double? rating;
  final double size;

  final String? title;
  final String? subtitle;

  const AppRatingArc({
    super.key,
    required this.rating,
    this.size = 200,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedRadialGauge(
          /// The animation duration.
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,

          /// Define the radius.
          /// If you omit this value, the parent size will be used, if possible.
          radius: 120,

          /// Gauge value.
          value: rating ?? 0,

          /// Optionally, you can configure your gauge, providing additional
          /// styles and transformers.
          axis: GaugeAxis(
            /// Provide the [min] and [max] value for the [value] argument.
            min: 0,
            max: 100,

            /// Render the gauge as a 180-degree arc.
            degrees: 180,

            /// Set the background color and axis thickness.
            style: GaugeAxisStyle(
              thickness: 40,
              background: _backgroundColor(context),
            ),
            progressBar: GaugeProgressBar.basic(
              gradient: GaugeAxisGradient(
                colors: [
                  _getActiveColor(context).$1,
                  _getActiveColor(context).$2,
                ],
              ),
            ),
            pointer: null,
          ),
          builder: (context, widget, value) {
            return Stack(
              children: [
                Transform.translate(
                  offset: const Offset(0, -9),
                  child: Transform.scale(
                    scale: 1.35,
                    child: SizedBox(
                      width: size + 100,
                      height: size + 100,
                      child: widget,
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        BetterIcons.starFilled,
                        color: context.colors.warning,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        (value / 20).toStringAsFixed(1),
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        if (title != null || subtitle != null) const SizedBox(height: 4),

        if (title != null) ...[
          Text(
            title!,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],

        if (subtitle != null)
          Text(
            subtitle!,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
      ],
    );
  }

  Color _backgroundColor(BuildContext context) => switch (rating) {
    == null || 0 => context.colors.surfaceVariant,
    < 60 => context.colors.errorContainer,
    < 80 => context.colors.warningContainer,
    _ => context.colors.successContainer,
  };

  (Color, Color) _getActiveColor(BuildContext context) {
    return switch (rating) {
      == null ||
      0 => (context.colors.surfaceVariant, context.colors.surfaceVariant),
      < 60 => (const Color(0xffFF5630), const Color(0xffFF7859)),
      < 80 => (const Color(0xffFFAB00), const Color(0xffFFBC33)),
      _ => (const Color(0xff22C55E), const Color(0xff7ADC9E)),
    };
  }
}

class ArcPainter extends CustomPainter {
  final double angle;
  final (Color, Color) activeColor;
  final Color inactiveColor;

  ArcPainter({
    required this.angle,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final paint = Paint()
      ..strokeWidth =
          30 // Adjust stroke width as needed
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square; // Rounded edges

    // Draw inactive arc
    paint.color = inactiveColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // Start from 180 degrees (bottom)
      pi, // Sweep 180 degrees (half circle)
      false,
      paint,
    );

    // Draw active arc with gradient
    final gradient = SweepGradient(
      startAngle: pi,
      endAngle: pi + angle,
      colors: [activeColor.$1, activeColor.$2],
    );
    paint.shader = gradient.createShader(
      Rect.fromCircle(center: center, radius: radius),
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // Start from 180 degrees
      angle, // Sweep the calculated angle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant ArcPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}
