import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/breadcrumb/breadcrumb.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

class BreadcrumbBrandingGuidelinesCard extends StatelessWidget {
  const BreadcrumbBrandingGuidelinesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1080,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            AppBreadcrumb(
              items: [
                BreadcrumbOption(title: 'Home', value: 'Home'),
                BreadcrumbOption(title: 'Docs', value: 'Docs'),
                BreadcrumbOption(
                  title: 'Design Guidelines',
                  value: 'Design Guidelines',
                ),
                BreadcrumbOption(title: 'Branding', value: 'Branding'),
              ],
              onPressed: (value) {},
              separator: BreadcrumbSeparator.slash,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Branding Guidelines',
                  style: context.textTheme.headlineSmall,
                ),
                Row(
                  spacing: 12,
                  children: [
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Edit Guidelines',
                      color: SemanticColor.neutral,
                      prefixIcon: BetterIcons.pencilEdit01Outline,
                    ),
                    AppFilledButton(
                      onPressed: () {},
                      text: 'Download Assets',
                      prefixIcon: BetterIcons.arrowDown03Outline,
                      color: SemanticColor.neutral,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
