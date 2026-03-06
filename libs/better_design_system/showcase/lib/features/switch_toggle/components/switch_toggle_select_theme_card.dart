import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:flutter/material.dart';

class SwitchToggleSelectThemeCard extends StatefulWidget {
  const SwitchToggleSelectThemeCard({super.key});

  @override
  State<SwitchToggleSelectThemeCard> createState() =>
      _SwitchToggleSelectThemeCardState();
}

class _SwitchToggleSelectThemeCardState
    extends State<SwitchToggleSelectThemeCard> {
  final List<String> themes = ['Light', 'Dark'];

  String selectedTheme = 'Light';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 385,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please select application theme:',
              style: context.textTheme.labelLarge,
            ),
            AppToggleSwitchButtonGroup<String>(
              isExpanded: true,
              isRounded: true,
              options:
                  themes
                      .map(
                        (e) => ToggleSwitchButtonGroupOption(
                          value: e,
                          label: e,
                          icon:
                              e == 'Light'
                                  ? BetterIcons.sun02Outline
                                  : BetterIcons.moon02Outline,
                          selectedIcon:
                              e == 'Light'
                                  ? BetterIcons.sun01Filled
                                  : BetterIcons.moon02Filled,
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedTheme = value;
                });
              },
              selectedValue: selectedTheme,
            ),
          ],
        ),
      ),
    );
  }
}
