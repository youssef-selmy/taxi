import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/tooltip/tooltip.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TooltipDesignAssistantCard extends StatelessWidget {
  const TooltipDesignAssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Design Assistant', style: context.textTheme.titleSmall),
            AppDivider(height: 36),
            Column(
              spacing: 20,
              children: [
                AppTooltip(
                  title: 'title',
                  subtitle:
                      '"Let AI enhance your layout by automatically adjusting spacing and alignment for a cleaner, more professional look".',
                  primaryButton: AppFilledButton(
                    onPressed: () {},
                    text: 'Upgrade to apply',
                  ),
                  trigger: TooltipTrigger.always,
                  size: TooltipSize.large,
                  alignment: TooltipAlignment.left,
                  child: _buildDesignAssistantItem(
                    context,
                    icon: BetterIcons.dashboardSquare01Filled,
                    backgroundColor: SemanticColor.insight,
                    title: 'Smart Layout',

                    titleColor: context.colors.onSurfaceVariant,
                    suffixIcon: BetterIcons.squareLock02Filled,
                  ),
                ),
                _buildDesignAssistantItem(
                  context,
                  icon: BetterIcons.userStoryFilled,
                  backgroundColor: SemanticColor.error,
                  title: 'Stock Image Finder',
                ),
                _buildDesignAssistantItem(
                  context,
                  icon: BetterIcons.arrowDown03Outline,
                  backgroundColor: SemanticColor.primary,
                  title: 'Export to Multiple Formats',
                ),
                _buildDesignAssistantItem(
                  context,
                  icon: BetterIcons.clock01Filled,
                  backgroundColor: SemanticColor.warning,
                  title: 'Version History',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesignAssistantItem(
    BuildContext context, {
    required IconData icon,
    required SemanticColor backgroundColor,
    required String title,
    Color? titleColor,
    IconData? suffixIcon,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    spacing: 8,
    children: [
      Row(
        spacing: 12,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: backgroundColor.main(context),
            ),
            child: Icon(
              icon,
              size: 20,
              color: backgroundColor.onColor(context),
            ),
          ),
          Text(
            title,
            style: context.textTheme.labelLarge?.copyWith(
              color: titleColor ?? context.colors.onSurface,
            ),
          ),
        ],
      ),
      if (suffixIcon != null)
        Icon(suffixIcon, size: 16, color: context.colors.onSurfaceVariant),
    ],
  );
}
