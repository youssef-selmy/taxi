import 'package:better_design_system/templates/select_language_dialog_template/select_language_dialog_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/core/blocs/settings.bloc.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final language = supportedLanguages.firstWhere(
          (element) => element.code == state.locale,
        );
        return CupertinoButton(
          child: language.image.image(width: 30, height: 30),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AppSelectLanguageDialogTemplate(
                  onLanguageSelected: (language) {
                    context.read<SettingsCubit>().changeLanguage(language);
                    Navigator.of(context).pop();
                  },
                  selectedLocale: language.code,
                );
              },
            );
          },
        );
      },
    );
  }
}
