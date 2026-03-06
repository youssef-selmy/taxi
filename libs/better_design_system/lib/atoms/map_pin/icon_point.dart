import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';

typedef BetterIconPoint = AppIconPoint;

class AppIconPoint extends StatelessWidget {
  final SemanticColor color;
  final IconData iconData;

  const AppIconPoint({
    super.key,
    this.color = SemanticColor.tertiary,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color.main(context),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: color.onColor(context), size: 16),
    );
  }
}
