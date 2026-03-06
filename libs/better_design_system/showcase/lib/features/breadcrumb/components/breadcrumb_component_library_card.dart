import 'package:better_design_system/atoms/breadcrumb/breadcrumb.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BreadcrumbComponentLibraryCard extends StatelessWidget {
  const BreadcrumbComponentLibraryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1080,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Component Library',
                  style: context.textTheme.headlineSmall,
                ),
                Row(
                  spacing: 12,
                  children: [
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'Manage Versions',
                      color: SemanticColor.neutral,
                    ),
                    AppFilledButton(
                      onPressed: () {},
                      text: 'Add Component',
                      prefixIcon: BetterIcons.add01Filled,
                    ),
                  ],
                ),
              ],
            ),

            AppBreadcrumb(
              items: [
                BreadcrumbOption(
                  title: 'Dashboard',
                  value: 'Dashboard',
                  icon: BetterIcons.dashboardSquare01Outline,
                ),
                BreadcrumbOption(
                  title: 'Assets',
                  value: 'Assets',
                  icon: BetterIcons.folder02Outline,
                ),
                BreadcrumbOption(
                  title: 'Library',
                  value: 'Library',
                  icon: BetterIcons.layersLogoOutline,
                ),
              ],
              onPressed: (value) {},
              separator: BreadcrumbSeparator.arrow,
            ),
          ],
        ),
      ),
    );
  }
}
