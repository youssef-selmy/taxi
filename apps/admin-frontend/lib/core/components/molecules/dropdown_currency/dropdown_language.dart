import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/settings.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_icons/better_icons.dart';

class AppDropdownLanguage extends StatelessWidget {
  const AppDropdownLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return AppDropdownField.single(
          prefixIcon: BetterIcons.globe02Outline,
          label: context.tr.language,
          initialValue: state.locale,
          onChanged: locator<SettingsCubit>().changeLanguage,
          items: languages
              .map(
                (language) => AppDropdownItem(
                  title: language.title,
                  value: language.code,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class LanguageItem {
  final String title;
  final String code;

  LanguageItem({required this.title, required this.code});
}

final languages = [
  LanguageItem(title: "English (US)", code: "en"),
  LanguageItem(title: "English (UK)", code: "en_GB"),
  LanguageItem(title: "Deutsch", code: "de"),
  LanguageItem(title: "Español", code: "es"),
  LanguageItem(title: "Français", code: "fr"),
  LanguageItem(title: "Italiano", code: "it"),
  LanguageItem(title: "Nederlands", code: "nl"),
  LanguageItem(title: "Polski", code: "pl"),
  LanguageItem(title: "Português", code: "pt"),
  LanguageItem(title: "Русский", code: "ru"),
  LanguageItem(title: "Türkçe", code: "tr"),
  LanguageItem(title: "中文 (简体)", code: "zh_CN"),
  LanguageItem(title: "中文 (繁體)", code: "zh_TW"),
  LanguageItem(title: "日本語", code: "ja"),
  LanguageItem(title: "한국어", code: "ko"),
  LanguageItem(title: "العربية", code: "ar"),
  LanguageItem(title: "हिन्दी", code: "hi"),
  LanguageItem(title: "ไทย", code: "th"),
  LanguageItem(title: "Tiếng Việt", code: "vi"),
  LanguageItem(title: "Bahasa Indonesia", code: "id"),
  LanguageItem(title: "Malay", code: "ms"),
  LanguageItem(title: "فارسی", code: "fa"),
  LanguageItem(title: "Suomi", code: "fi"),
  LanguageItem(title: "Norsk", code: "no"),
  LanguageItem(title: "Svenska", code: "sv"),
  LanguageItem(title: "Հայերեն", code: "hy"),
  LanguageItem(title: "Română", code: "ro"),
  LanguageItem(title: "Українська", code: "uk"),
  LanguageItem(title: "বাংলা", code: "bn"),
  LanguageItem(title: "اردو", code: "ur"),
  LanguageItem(title: "Eesti", code: "et"),
];
