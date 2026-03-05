import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/blocs/settings.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/features/settings_appearance/presentation/blocs/settings_appearance.bloc.dart';
import 'package:admin_frontend/gen/assets.gen.dart';

class DarkLightToggleCard extends StatelessWidget {
  final bool isDarkMode;
  final bool isSelected;

  const DarkLightToggleCard({
    super.key,
    required this.isDarkMode,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        locator<SettingsCubit>().changeThemeMode(
          isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
        context.read<SettingsAppearanceBloc>().onChangeDarkMode(isDarkMode);
      },
      minimumSize: Size(0, 0),
      child: Container(
        width: 225,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: kBorder(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppRadio(groupValue: true, value: isSelected),
            const SizedBox(height: 8),
            switch (isDarkMode) {
              true => Assets.lottie.darkMode.lottie(
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
              false => Assets.lottie.lightMode.lottie(
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            },
            const SizedBox(height: 8),
            Text(
              isDarkMode ? context.tr.darkMode : context.tr.lightMode,
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
