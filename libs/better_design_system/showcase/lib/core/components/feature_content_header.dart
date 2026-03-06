import 'package:better_design_showcase/features/home/presentation/components/theme_toggle.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:better_icons/better_icon.dart';
import 'package:better_design_system/atoms/buttons/soft_button.dart';

enum DeviceViewport { mobile, tablet, desktop }

class FeatureContentHeader extends StatelessWidget {
  const FeatureContentHeader({
    super.key,
    required this.title,
    required this.deviceViewport,
    required this.onViewportChanged,
    this.onAddPressed,
    this.onCodePressed,
    this.children = const [],
  });

  final String title;
  final DeviceViewport deviceViewport;
  final ValueChanged<DeviceViewport> onViewportChanged;
  final VoidCallback? onAddPressed;
  final VoidCallback? onCodePressed;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: context.textTheme.titleSmall),
              const Spacer(),
              const AppThemeToggle(),
              const SizedBox(width: 8),
              AppSoftButton(
                onPressed: onAddPressed,
                prefixIcon: BetterIcons.add01Filled,
                color: SemanticColor.neutral,
                size: ButtonSize.small,
              ),
              const SizedBox(width: 8),
              AppToggleSwitchButtonGroup<DeviceViewport>(
                options: [
                  ToggleSwitchButtonGroupOption<DeviceViewport>(
                    value: DeviceViewport.mobile,
                    icon: BetterIcons.smartPhone01Outline,
                    selectedIcon: BetterIcons.smartPhone01Outline,
                  ),
                  ToggleSwitchButtonGroupOption<DeviceViewport>(
                    value: DeviceViewport.tablet,
                    icon: BetterIcons.smartPhone01Outline,
                    selectedIcon: BetterIcons.smartPhone01Outline,
                  ),
                  ToggleSwitchButtonGroupOption<DeviceViewport>(
                    value: DeviceViewport.desktop,
                    icon: BetterIcons.computerOutline,
                    selectedIcon: BetterIcons.computerOutline,
                  ),
                ],
                selectedValue: deviceViewport,
                onChanged: onViewportChanged,
              ),
              const SizedBox(width: 8),
              AppSoftButton(
                onPressed: onCodePressed,
                prefixIcon: BetterIcons.squareLock02Outline,
                text: 'Code',
                color: SemanticColor.neutral,
                size: ButtonSize.small,
              ),
            ],
          ),
          if (children.isNotEmpty) ...[const SizedBox(height: 16), ...children],
        ],
      ),
    );
  }
}
