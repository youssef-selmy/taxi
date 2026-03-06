import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterDestinationPoint = AppDestinationPoint;

class AppDestinationPoint extends StatelessWidget {
  final SemanticColor color;

  const AppDestinationPoint({super.key, this.color = SemanticColor.primary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: context.colors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: context.colors.surface,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
