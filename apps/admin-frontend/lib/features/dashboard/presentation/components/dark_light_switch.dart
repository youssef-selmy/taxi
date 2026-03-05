import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/molecules/dark_light_switch/dark_light_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/settings.bloc.dart';

class DarkLightSwitch extends StatelessWidget {
  const DarkLightSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return AppDarkLightSwitch(
          selectedThemeMode: state.themeMode,
          onThemeModeChanged: (newThemeMode) {
            context.read<SettingsCubit>().changeThemeMode(newThemeMode);
          },
        );
      },
    );
  }
}
