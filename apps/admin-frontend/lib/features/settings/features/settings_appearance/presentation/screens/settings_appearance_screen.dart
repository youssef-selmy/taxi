import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/settings.bloc.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_currency/dropdown_language.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/features/settings_appearance/presentation/blocs/settings_appearance.bloc.dart';
import 'package:admin_frontend/features/settings/features/settings_appearance/presentation/components/dark_light_toggle_card.dart';
import 'package:admin_frontend/features/settings/presentation/components/setting_switch_item.dart';
import 'package:admin_frontend/features/settings/presentation/components/settings_page_header.dart';

@RoutePage()
class SettingsAppearanceScreen extends StatelessWidget {
  const SettingsAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsAppearanceBloc(),
      child: BlocBuilder<SettingsAppearanceBloc, SettingsAppearanceState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SettingsPageHeader(title: context.tr.appearance),
                const SizedBox(height: 16),
                Text(
                  context.tr.appearance,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                SettingSwitchItem(
                  title: context.tr.systemDefault,
                  subtitle: context.tr.useSystemDefaultTheme,
                  value: state.darkModeSystemDefault,
                  onChanged: (value) {
                    if (value) {
                      locator<SettingsCubit>().toggleThemeMode(
                        ThemeMode.system,
                      );
                    } else {
                      locator<SettingsCubit>().toggleThemeMode(ThemeMode.light);
                    }
                    context
                        .read<SettingsAppearanceBloc>()
                        .onDarkModeSystemDefaultChange(value);
                  },
                ),
                if (state.darkModeSystemDefault == false) ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      DarkLightToggleCard(
                        isDarkMode: false,
                        isSelected: !state.darkModeEnabled,
                      ),
                      const SizedBox(width: 8),
                      DarkLightToggleCard(
                        isDarkMode: true,
                        isSelected: state.darkModeEnabled,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 48),
                AppDropdownLanguage(),
                const SizedBox(height: 300),
              ],
            ),
          );
        },
      ),
    );
  }
}
