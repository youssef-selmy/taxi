import 'package:better_design_system/templates/map_settings_screen/map_settings_screen.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/settings.bloc.dart';

@RoutePage()
class SettingsMapScreen extends StatelessWidget {
  const SettingsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return AppMapSettingsScreen(
          mapProvider: state.mapProvider,
          onMapProviderChanged: (newProvider) {
            context.read<SettingsCubit>().changeMapProvider(newProvider);
          },
        );
      },
    );
  }
}
