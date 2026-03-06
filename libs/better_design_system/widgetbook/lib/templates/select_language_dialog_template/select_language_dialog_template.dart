import 'package:better_design_system/templates/select_language_dialog_template/select_language_dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSelectLanguageDialogTemplate)
Widget defaultSelectLanguageDialogTemplate(BuildContext context) {
  return AppSelectLanguageDialogTemplate(
    selectedLocale: 'en',
    onLanguageSelected: (String language) {
      // Handle language selection
    },
  );
}
