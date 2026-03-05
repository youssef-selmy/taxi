import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class AppStepperDots extends StatelessWidget {
  final int activeIndex;
  final int count;
  final bool isWide;

  const AppStepperDots({
    super.key,
    required this.activeIndex,
    required this.count,
    this.isWide = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: isWide ? 64 : 32,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: activeIndex >= index
                ? context.colors.primary
                : context.colors.outline,
          ),
        ),
      ),
    );
  }
}
