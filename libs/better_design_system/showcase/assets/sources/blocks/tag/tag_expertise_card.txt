import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TagExpertiseCard extends StatelessWidget {
  const TagExpertiseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 381,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What are your expert at?',
              style: context.textTheme.labelLarge,
            ),
            SizedBox(height: 16),
            AppTextField(
              label: 'Expertise',
              labelHelpText: '(Select 8 max.)',
              hint: 'Enter to add...',
              suffixIcon: Icon(
                BetterIcons.informationCircleFilled,
                size: 20,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                AppTag(
                  text: 'User Interface Design',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
                AppTag(
                  text: 'Product Design',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
                AppTag(
                  text: 'Development',
                  color: SemanticColor.neutral,
                  onRemovedPressed: () {},
                  style: TagStyle.outline,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppFilledButton(onPressed: () {}, text: 'Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
