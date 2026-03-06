import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:generic_map/interfaces/center_marker.dart';

typedef BetterMyLocationPoint = AppMyLocationPoint;

class AppMyLocationPoint extends StatefulWidget {
  const AppMyLocationPoint({super.key});

  @override
  State<AppMyLocationPoint> createState() => _AppMyLocationPointState();

  static CenterMarker marker(Key key) => CenterMarker(
    widget: AppMyLocationPoint(key: key),
    size: const Size(55, 55),
    alignment: Alignment.center,
  );
}

class _AppMyLocationPointState extends State<AppMyLocationPoint>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationAlpha;
  late Animation<double> _animationScale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animationAlpha = Tween<double>(begin: 0.15, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationScale = Tween<double>(begin: 0, end: 0.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Animated radiating circle
            Transform.scale(
              scale: _animationScale.value,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colors.primary.withValues(
                    alpha: _animationAlpha.value,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Static inner circles from original design
            Container(
              decoration: BoxDecoration(
                color: context.colors.primary,
                border: Border.all(color: context.colors.surface, width: 1.5),
                shape: BoxShape.circle,
              ),
              width: 15,
              height: 15,
            ),
          ],
        );
      },
    );
  }
}
