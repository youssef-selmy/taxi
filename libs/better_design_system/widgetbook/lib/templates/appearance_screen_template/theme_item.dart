import 'package:better_design_system/templates/appearance_screen_template/theme_item.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppThemeItem)
Widget defaultThemeItem(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppThemeItem(
      theme: context.knobs.object.dropdown(
        label: 'Theme',
        options: BetterThemes.values,
        labelBuilder: (value) => value.name,
      ),
      onPressed: () {},
      isSelected: context.knobs.boolean(
        label: 'Is Selected',
        initialValue: false,
      ),
    ),
  );
}
