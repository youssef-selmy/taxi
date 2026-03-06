import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterColoredHeaderCard = AppColoredHeaderCard;

class AppColoredHeaderCard extends StatelessWidget {
  final Widget header;
  final Widget content;
  final VoidCallback? onTap;

  const AppColoredHeaderCard({
    super.key,
    required this.header,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: const Alignment(1.00, 0.00),
            end: const Alignment(-0.00, 1.00),
            colors: [context.colors.primary, context.colors.primaryBold],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: header,
            ),
            Transform.scale(
              scale: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.colors.surfaceVariantLow,
                  border: Border.all(color: context.colors.outline, width: 1),
                ),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
