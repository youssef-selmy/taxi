import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeToggle extends StatefulWidget {
  final ValueChanged<ThemeMode>? onChanged;
  final ThemeMode? selectedThemeMode;

  const AppThemeToggle({super.key, this.onChanged, this.selectedThemeMode});

  @override
  State<AppThemeToggle> createState() => _AppThemeToggleState();
}

class _AppThemeToggleState extends State<AppThemeToggle> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    _themeMode =
        widget.selectedThemeMode ??
        context.read<SettingsCubit>().state.themeMode;
    super.initState();
  }

  @override
  void didUpdateWidget(AppThemeToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedThemeMode != null &&
        widget.selectedThemeMode != oldWidget.selectedThemeMode) {
      setState(() {
        _themeMode = widget.selectedThemeMode!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppToggleSwitchButtonGroup<ThemeMode>(
      size: ToggleSwitchButtonGroupSize.small,
      options: [
        ToggleSwitchButtonGroupOption<ThemeMode>(
          value: ThemeMode.light,
          icon: BetterIcons.sun02Outline,
          selectedIcon: BetterIcons.sun01Filled,
        ),
        ToggleSwitchButtonGroupOption<ThemeMode>(
          value: ThemeMode.system,
          icon: BetterIcons.computerOutline,
          selectedIcon: BetterIcons.computerFilled,
        ),
        ToggleSwitchButtonGroupOption<ThemeMode>(
          value: ThemeMode.dark,
          icon: BetterIcons.moon02Outline,
          selectedIcon: BetterIcons.moon02Filled,
        ),
      ],
      selectedValue: _themeMode,
      onChanged: (ThemeMode value) {
        setState(() {
          _themeMode = value;
        });

        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}
