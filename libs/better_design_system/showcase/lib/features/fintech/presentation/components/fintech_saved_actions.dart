import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FintechSavedActions extends StatelessWidget {
  const FintechSavedActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Saved Actions', style: context.textTheme.titleSmall),
                AppOutlinedButton(
                  onPressed: () {},
                  text: 'View All',
                  size: ButtonSize.medium,
                  color: SemanticColor.neutral,
                ),
              ],
            ),
          ),
          AppDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _savedActionsItem(
                  context,
                  icon: BetterIcons.ideaFilled,
                  title: 'Utility bills',
                  price: '\$30.00',
                  iconColor: context.colors.warning,
                ),
                AppDivider(height: 24),
                _savedActionsItem(
                  context,
                  icon: BetterIcons.home01Filled,
                  title: 'Mortgage Installment',
                  price: '\$200.00',
                  iconColor: context.colors.onSurfaceVariant,
                ),
                AppDivider(height: 24),
                _savedActionsItem(
                  context,
                  icon: BetterIcons.building02Outline,
                  title: 'Daycare Fee',
                  price: '\$70.00',
                  iconColor: context.colors.primary,
                ),
                AppDivider(height: 24),
                _savedActionsItem(
                  context,
                  icon: BetterIcons.car05Filled,
                  title: 'Car Insurance',
                  price: '\$100.00',
                  iconColor: context.colors.insight,
                ),
                AppDivider(height: 24),
                _savedActionsItem(
                  context,
                  icon: BetterIcons.globe02Filled,
                  title: 'Internet Payment',
                  price: '\$30.00',
                  iconColor: context.colors.info,
                ),
              ],
            ),
          ),
          AppDivider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Save a New Action',
                    color: SemanticColor.neutral,
                    prefixIcon: BetterIcons.addCircleOutline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _savedActionsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String price,
    required Color iconColor,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        spacing: 12,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Icon(icon, size: 24, color: iconColor),
          ),
          Text(title, style: context.textTheme.labelLarge),
        ],
      ),

      Row(
        spacing: 6,
        children: [
          Text(price, style: context.textTheme.titleSmall),
          Icon(
            BetterIcons.arrowRight01Outline,
            size: 24,
            color: context.colors.onSurfaceVariant,
          ),
        ],
      ),
    ],
  );
}
