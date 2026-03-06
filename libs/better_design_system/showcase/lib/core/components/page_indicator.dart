import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AppPageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const AppPageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                currentPage == index
                    ? context.colors.primary
                    : context.colors.surfaceVariant,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
