import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppToggleSwitchButtonGroup)
Widget defaultToggleSwitchButtonGroup(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 30,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 600,
              child: AppToggleSwitchButtonGroup(
                isExpanded: context.knobs.boolean(
                  label: 'Expanded',
                  description:
                      'When enabled, the buttons will be evenly distributed across the full available width. Otherwise, the buttons will size themselves based on their content.',

                  initialValue: false,
                ),
                title: 'Label',
                subtitle: '(Sublabel)',
                isRounded: context.knobs.boolean(
                  label: 'Rounded',
                  initialValue: false,
                ),
                onChanged: (value) {},
                selectedValue: 4,
                options: [
                  ToggleSwitchButtonGroupOption(
                    icon: BetterIcons.moon02Outline,
                    label: 'LabelLabel',
                    value: 1,
                  ),
                  ToggleSwitchButtonGroupOption(
                    icon: BetterIcons.moon02Outline,
                    label: 'Lab',
                    value: 2,
                  ),
                  ToggleSwitchButtonGroupOption(
                    icon: BetterIcons.moon02Outline,
                    label: 'La',
                    value: 3,
                  ),
                  ToggleSwitchButtonGroupOption(
                    icon: BetterIcons.moon02Outline,
                    label: 'L',
                    value: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppToggleSwitchButtonGroup(
              title: 'Label',
              subtitle: '(Sublabel)',
              selectedValue: 2,
              isRounded: context.knobs.boolean(
                label: 'Rounded',
                initialValue: false,
              ),
              onChanged: (value) {},
              options: [
                ToggleSwitchButtonGroupOption(label: 'LabelLabel', value: 1),
                ToggleSwitchButtonGroupOption(label: 'Lab', value: 2),
                ToggleSwitchButtonGroupOption(label: 'La', value: 3),
                ToggleSwitchButtonGroupOption(label: 'L', value: 4),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppToggleSwitchButtonGroup(
              selectedValue: 3,
              isRounded: context.knobs.boolean(
                label: 'Rounded',
                initialValue: false,
              ),
              onChanged: (value) {},
              options: [
                ToggleSwitchButtonGroupOption(
                  icon: BetterIcons.moon02Outline,
                  value: 1,
                ),
                ToggleSwitchButtonGroupOption(
                  icon: BetterIcons.moon02Outline,
                  value: 2,
                ),
                ToggleSwitchButtonGroupOption(
                  icon: BetterIcons.moon02Outline,
                  value: 3,
                ),
                ToggleSwitchButtonGroupOption(
                  icon: BetterIcons.moon02Outline,
                  value: 4,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
