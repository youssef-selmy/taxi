import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/dialog_footer.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDialogFooter)
Widget defaultDialogFooter(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppDialogFooter(
      primaryAction: AppFilledButton(onPressed: () {}, text: 'Primary'),
      secondaryAction: AppOutlinedButton(
        onPressed: () {},
        text: 'Secondary',
        color: SemanticColor.primary,
      ),
      tertiaryAction: AppTextButton(
        onPressed: () {},
        text: 'Tertiary',
        color: SemanticColor.error,
      ),
      direction: context.knobs.object.dropdown(
        label: 'Direction',
        options: DialogFooterDirection.values,
        initialOption: DialogFooterDirection.horizontal,
        labelBuilder: (option) => option.name,
      ),
    ),
  );
}
