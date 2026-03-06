import 'package:better_design_system/molecules/dark_light_switch/dark_light_switch.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDarkLightSwitch)
Widget defaultDarkLightSwitch(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppDarkLightSwitch(
        selectedThemeMode: context.knobs.object.dropdown(
          label: 'Select Theme',
          description: 'Choose your preferred theme mode',
          options: [ThemeMode.light, ThemeMode.dark],
          labelBuilder: (value) => value.name,
          initialOption: ThemeMode.light,
        ),

        onThemeModeChanged: (ThemeMode mode) {},
      ),
    ],
  );
}
