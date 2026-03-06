import 'package:better_design_system/atoms/buttons/soft_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceGrayContainer extends StatelessWidget {
  const EcommerceGrayContainer({
    super.key,
    this.height,
    this.showControls = true,
  });

  final double? height;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showControls)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      AppSoftButton(
                        onPressed: () {},
                        prefixIcon: BetterIcons.arrowLeft01Outline,
                        size: ButtonSize.medium,
                        color: SemanticColor.neutral,
                      ),
                      const Spacer(),
                      AppSoftButton(
                        onPressed: () {},
                        prefixIcon: BetterIcons.arrowRight01Outline,
                        size: ButtonSize.medium,
                        color: SemanticColor.neutral,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (showControls)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: context.colors.surfaceVariant,
                      border: Border.all(color: context.colors.outline),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: context.colors.surfaceVariant,
                      border: Border.all(color: context.colors.outline),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
