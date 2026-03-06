import 'package:better_design_system/templates/appearance_screen_template/appearance_screen_template.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppAppearanceScreenTemplate)
Widget defaultAppearanceScreenTemplate(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppAppearanceScreenTemplate(
        canChangeTheme: context.knobs.boolean(
          label: 'Can Change Theme',
          initialValue: true,
        ),
        themeMode: context.knobs.object.dropdown(
          label: 'Theme Mode',
          options: ThemeMode.values,
          labelBuilder: (value) => value.name,
        ),
        onThemeModeChanged: (value) {},
        theme: context.knobs.object.dropdown(
          label: 'Theme',
          options: BetterThemes.values,
          labelBuilder: (value) => value.name,
        ),
        onThemeChanged: (value) {},
      ),
    ],
  );
}
