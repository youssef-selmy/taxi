import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class DividerSettingCard extends StatelessWidget {
  const DividerSettingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 281,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Setting', style: context.textTheme.titleSmall),
            const SizedBox(height: 12),
            AppTextField(
              hint: 'Search',
              density: TextFieldDensity.noDense,
              prefixIcon: Icon(
                BetterIcons.search01Filled,
                color: context.colors.onSurfaceVariant,
              ),
              isFilled: false,
            ),
            const SizedBox(height: 20),
            Row(
              spacing: 8,
              children: [
                Assets.images.others.sun01.image(width: 20, height: 20),
                Text(
                  'Display and lightning',
                  style: context.textTheme.labelLarge,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11.5),
              child: const AppDivider(),
            ),
            Row(
              spacing: 8,
              children: [
                Assets.images.others.notification02.image(
                  width: 20,
                  height: 20,
                ),
                Text('Notification', style: context.textTheme.labelLarge),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11.5),
              child: const AppDivider(),
            ),
            Row(
              spacing: 8,
              children: [
                Assets.images.others.shield01.image(width: 20, height: 20),
                Text('Privacy & Security', style: context.textTheme.labelLarge),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11.5),
              child: const AppDivider(),
            ),
            Row(
              spacing: 8,
              children: [
                Assets.images.others.paintBoard.image(width: 20, height: 20),
                Text('Themes', style: context.textTheme.labelLarge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
