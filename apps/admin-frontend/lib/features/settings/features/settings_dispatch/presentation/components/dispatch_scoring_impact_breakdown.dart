import 'dart:math' as math;
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class AppDispatchScoringImpactBreakdown extends StatelessWidget {
  final double distanceWeight;
  final double driverRatingWeight;
  final double idleTimeWeight;
  final double cancelRateWeight;
  final Duration duration;
  final double width;
  final double height;
  final double radius;

  const AppDispatchScoringImpactBreakdown({
    super.key,
    required this.distanceWeight,
    required this.driverRatingWeight,
    required this.idleTimeWeight,
    required this.cancelRateWeight,
    this.width = 800,
    this.height = 32,
    this.radius = 4,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    // Normalize
    final total =
        (distanceWeight +
        driverRatingWeight +
        idleTimeWeight +
        cancelRateWeight);
    double pct(double w) => total <= 0 ? 0 : (w / total).clamp(0, 1);

    // Compute widths; force the last one to fill any rounding remainder.
    final w1 = width * pct(distanceWeight);
    final w2 = width * pct(driverRatingWeight);
    final w3 = width * pct(idleTimeWeight);
    final w4 = math.max(0, width - w1 - w2 - w3).toDouble();

    Widget seg({
      required double targetWidth,
      required Color color,
      required IconData icon,
      BorderRadius? radius,
    }) {
      return AnimatedContainer(
        duration: duration,
        curve: Curves.easeOut,
        width: targetWidth,
        height: height,
        decoration: BoxDecoration(color: color, borderRadius: radius),
        child: Center(child: Icon(icon, color: Colors.white, size: 16)),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // left segment with rounded left corners
          seg(
            targetWidth: w1,
            color: const Color(0xFF36BA98),
            icon: BetterIcons.navigation03Filled,
            radius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
            ),
          ),
          // middle segments (no radius)
          seg(
            targetWidth: w2,
            color: const Color(0xFFB771E5),
            icon: BetterIcons.starFilled,
          ),
          seg(
            targetWidth: w3,
            color: const Color(0xFFE76F51),
            icon: BetterIcons.clock01Filled,
          ),
          // right segment with rounded right corners
          seg(
            targetWidth: w4,
            color: const Color(0xFF4635B1),
            icon: BetterIcons.cancel01Filled,
            radius: BorderRadius.only(
              topRight: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
        ],
      ),
    );
  }
}
