import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/fab/fab.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ButtonProgramsCard extends StatelessWidget {
  const ButtonProgramsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              spacing: 12,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.colors.outline),
                  ),
                  child: Icon(
                    BetterIcons.pencilEdit02Filled,
                    size: 24,
                    color: context.colors.primary,
                  ),
                ),
                Text('Today\'s programs', style: context.textTheme.titleSmall),
              ],
            ),
            AppDivider(height: 36),
            _buildProgramItem(context, label: 'Electricity bill reminder'),
            const SizedBox(height: 16),
            _buildProgramItem(context, label: 'Review of Chapter 3 Math'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppFab(
                  onPressed: () {},
                  icon: BetterIcons.add01Outline,
                  style: AppFabStyle.soft,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramItem(BuildContext context, {required String label}) {
    return Stack(
      children: [
        AppTextField(label: label, hint: 'Placeholder', maxLines: 3),
        Positioned(
          right: 12,
          bottom: 12,
          child: Row(
            spacing: 12,
            children: <Widget>[
              Icon(
                BetterIcons.delete03Outline,
                size: 20,
                color: context.colors.onSurface,
              ),
              Icon(
                BetterIcons.pencilEdit01Outline,
                size: 20,
                color: context.colors.onSurface,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
