import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ModalDeleteCard extends StatelessWidget {
  const ModalDeleteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 496,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: context.colors.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      BetterIcons.delete03Filled,
                      size: 32,
                      color: context.colors.error,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Delete Favorite Location?',
                  style: context.textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'You won\'t be able to restore this information once you delete\n them',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colors.onSurfaceVariantLow,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const AppDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: 'Confirm & Delete',
                    color: SemanticColor.error,
                  ),
                ),
                Expanded(
                  child: AppFilledButton(onPressed: () {}, text: 'Keep'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
