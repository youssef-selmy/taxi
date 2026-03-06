import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/slider/range_slider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TooltipStarterCard extends StatelessWidget {
  const TooltipStarterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Starter', style: context.textTheme.titleLarge),
            SizedBox(height: 8),
            Row(
              spacing: 8,
              children: [
                Text(
                  '\$29.99',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
                Text(
                  'Per month',
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              ],
            ),
            AppDivider(height: 36),
            Text('Features', style: context.textTheme.labelLarge),
            SizedBox(height: 16),
            Column(
              spacing: 12,
              children: [
                _buildEnabledFeature(context, 'Access to basic design tools'),
                _buildEnabledFeature(context, '5 active projects'),
                _buildEnabledFeature(
                  context,
                  'Standard quality output (72dpi)',
                ),

                AppTooltip(
                  title: 'Team work',
                  subtitle:
                      'Invite teammates to edit, comment, and manage projects in real time. Available in Pro & Studio plans.',
                  trigger: TooltipTrigger.always,
                  size: TooltipSize.large,
                  alignment: TooltipAlignment.left,
                  child: _buildDisabledFeature(context, 'Team work'),
                ),

                _buildDisabledFeature(context, 'Cloud space'),
              ],
            ),
            SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: AppFilledButton(onPressed: () {}, text: 'Get Started'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnabledFeature(BuildContext context, String title) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          BetterIcons.checkmarkCircle02Filled,
          size: 20,
          color: context.colors.primary,
        ),
        Text(title, style: context.textTheme.labelMedium?.variant(context)),
      ],
    );
  }

  Widget _buildDisabledFeature(BuildContext context, String title) {
    return Row(
      spacing: 8,
      children: [
        Icon(
          BetterIcons.removeCircleFilled,
          size: 20,
          color: context.colors.onSurfaceDisabled,
        ),
        Text(title, style: context.textTheme.labelMedium?.variant(context)),
      ],
    );
  }
}
