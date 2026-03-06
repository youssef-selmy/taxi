import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:flutter/material.dart';

typedef BetterDarkLightSwitch = AppDarkLightSwitch;

class AppDarkLightSwitch extends StatelessWidget {
  final ThemeMode selectedThemeMode;
  final Function(ThemeMode) onThemeModeChanged;

  const AppDarkLightSwitch({
    super.key,
    required this.selectedThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppToggleSwitchButtonGroup(
      selectedValue: selectedThemeMode,
      isRounded: true,
      options: [
        ToggleSwitchButtonGroupOption(
          value: ThemeMode.light,
          icon: BetterIcons.sun02Outline,
          selectedIcon: BetterIcons.sun01Filled,
        ),

        ToggleSwitchButtonGroupOption(
          value: ThemeMode.system,
          icon: BetterIcons.computerOutline,
          selectedIcon: BetterIcons.computerFilled,
        ),
        ToggleSwitchButtonGroupOption(
          value: ThemeMode.dark,
          icon: BetterIcons.moon02Outline,
          selectedIcon: BetterIcons.moon02Filled,
        ),
      ],
      onChanged: (value) {
        onThemeModeChanged(value);
      },
    );
  }
}
