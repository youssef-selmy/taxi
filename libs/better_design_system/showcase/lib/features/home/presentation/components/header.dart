import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/core/router/app_router.dart';
import 'package:better_design_showcase/features/home/presentation/components/theme_dropdown.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: AppNavbar(
        padding: EdgeInsets.symmetric(horizontal: 108, vertical: 20),
        prefix: Row(
          children: [
            Assets.images.logo.image(height: 40, width: 40),
            const SizedBox(width: 12),
            Text('BetterUI', style: context.textTheme.labelLarge),
            const SizedBox(width: 24),
          ],
        ),
        actions: [
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return AppTabMenuHorizontal<HeaderTabValues>(
                style: TabMenuHorizontalStyle.soft,
                color: SemanticColor.primary,
                tabs: [
                  TabMenuHorizontalOption(
                    title: 'Themes',
                    value: HeaderTabValues.themes,
                  ),
                  TabMenuHorizontalOption(
                    title: 'Templates',
                    value: HeaderTabValues.templates,
                  ),
                  TabMenuHorizontalOption(
                    title: 'Blocks',
                    value: HeaderTabValues.blocks,
                  ),
                  TabMenuHorizontalOption(
                    title: 'Docs',
                    value: HeaderTabValues.docs,
                  ),
                ],
                selectedValue: state.selectedHeaderTab,
                onChanged: (value) {
                  context.read<SettingsCubit>().changeHeaderTab(value);
                  switch (value) {
                    case HeaderTabValues.themes:
                      context.router.replaceAll([HomeRoute()]);
                      break;
                    case HeaderTabValues.templates:
                      context.router.replaceAll([TemplatesRoute()]);
                      break;
                    case HeaderTabValues.blocks:
                      context.router.replaceAll([BlocksRoute()]);
                      break;
                    case HeaderTabValues.docs:
                      context.router.replaceAll([DocsRoute()]);
                      break;
                  }
                },
              );
            },
          ),
        ],
        suffix: Row(
          children: [
            const SizedBox(width: 24),
            SizedBox(
              width: 260,
              child: AppTextField(
                iconPadding: EdgeInsets.zero,
                density: TextFieldDensity.noDense,
                isFilled: true,
                prefixIcon: Icon(
                  BetterIcons.search01Filled,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
                hint: 'Search',
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 98,
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return AppThemeDropdown(
                    initialValue: state.theme,
                    onChanged: (theme) {
                      context.read<SettingsCubit>().changeTheme(theme!);
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return AppToggleSwitchButtonGroup<ThemeMode>(
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
                  selectedValue: state.themeMode,
                  onChanged: (ThemeMode value) {
                    context.read<SettingsCubit>().changeThemeMode(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
