import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/config/language_data.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'select_language_list.dart';

typedef BetterSelectLanguageDialogTemplate = AppSelectLanguageDialogTemplate;

class AppSelectLanguageDialogTemplate extends StatefulWidget {
  final String? selectedLocale;
  final Function(String)? onLanguageSelected;

  const AppSelectLanguageDialogTemplate({
    super.key,
    required this.selectedLocale,
    this.onLanguageSelected,
  });

  @override
  State<AppSelectLanguageDialogTemplate> createState() =>
      _AppSelectLanguageDialogTemplateState();
}

class _AppSelectLanguageDialogTemplateState
    extends State<AppSelectLanguageDialogTemplate> {
  LanguageInfo? selectedLanguage;

  @override
  void initState() {
    selectedLanguage = supportedLanguages.byCode(widget.selectedLocale ?? '');
    selectedLanguage ??= supportedLanguages.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      defaultDialogType: DialogType.fullScreenBottomSheet,
      desktopDialogType: DialogType.dialog,
      title: context.strings.selectLanguage,
      icon: BetterIcons.flag02Filled,
      iconColor: SemanticColor.primary,
      primaryButton: AppFilledButton(
        isDisabled: selectedLanguage == null,
        text: context.strings.confirm,
        onPressed: () =>
            widget.onLanguageSelected?.call(selectedLanguage!.code),
      ),
      child: SizedBox(
        height: context.isDesktop ? 400 : null,
        child: SelectLanguageList(
          selectedLocale:
              widget.selectedLocale ??
              supportedLanguages.firstOrNull?.code ??
              '',
          onLanguageSelected: (String language) {
            setState(() {
              selectedLanguage = supportedLanguages.byCode(language);
            });
          },
        ),
      ),
    );
  }
}
