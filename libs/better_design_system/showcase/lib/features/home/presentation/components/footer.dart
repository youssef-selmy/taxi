import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(width: 1, color: context.colors.outline),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                AppOutlinedButton(
                  onPressed: () {
                    launchUrlString('https://lumeagency.io');
                  },
                  child: Assets.images.brands.lumeAgency.image(
                    height: 20,
                    width: 20,
                  ),
                ),
                AppOutlinedButton(
                  onPressed: () {
                    launchUrlString('https://bettersuite.io');
                  },
                  child: Assets.images.brands.bettersuite.image(
                    height: 20,
                    width: 20,
                  ),
                ),
                AppOutlinedButton(
                  onPressed: () {
                    launchUrlString('https://x.com/lume_agency_io');
                  },
                  child: Assets.images.brands.x.image(
                    height: 20,
                    width: 20,
                    color: context.colors.onSurface,
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '© 2025 BetterUI. All rights reserved.',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
