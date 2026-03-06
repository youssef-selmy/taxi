import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class TagSendMessageCard extends StatelessWidget {
  const TagSendMessageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 381,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send Message', style: context.textTheme.labelLarge),
            SizedBox(height: 16),
            AppTextField(
              initialValue: 'Hello@better.com',
              density: TextFieldDensity.dense,
              isFilled: false,
            ),
            AppDivider(height: 36),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  'To',
                  style: context.textTheme.labelLarge?.variant(context),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      AppTag(
                        prefixImage: ImageFaker().person.two,
                        text: 'Omar Vetrovs',
                        color: SemanticColor.neutral,
                        onRemovedPressed: () {},
                      ),
                      AppTag(
                        prefixImage: ImageFaker().person.three,
                        text: 'James Stanton',
                        color: SemanticColor.neutral,
                        onRemovedPressed: () {},
                      ),
                      AppTag(
                        prefixImage: ImageFaker().person.four,
                        text: 'Chance Rosser',
                        color: SemanticColor.neutral,
                        onRemovedPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Type username...',
                          style: context.textTheme.bodySmall?.variantLow(
                            context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppDivider(height: 36),
            AppTextField(hint: 'Subject', isFilled: false),
            SizedBox(height: 8),
            AppTextField(hint: 'Message', isFilled: false, maxLines: 4),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppFilledButton(
                    onPressed: () {},
                    text: 'Send Message',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
