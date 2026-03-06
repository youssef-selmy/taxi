import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalThemeTabBar extends StatelessWidget {
  const HorizontalThemeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return AppTabMenuHorizontal<BetterThemes?>(
            tabs:
                supportedThemes
                    .map(
                      (theme) => TabMenuHorizontalOption(
                        title: theme.name,
                        value: theme,
                      ),
                    )
                    .toList(),
            selectedValue: state.theme,
            onChanged: (theme) {
              if (theme != null) {
                context.read<SettingsCubit>().changeTheme(theme);
              }
            },
            style: TabMenuHorizontalStyle.soft,
            color: SemanticColor.neutral,
          );
        },
      ),
    );
  }
}
