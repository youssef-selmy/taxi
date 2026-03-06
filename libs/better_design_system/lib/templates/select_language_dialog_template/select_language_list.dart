import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/config/language_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/material.dart';

class SelectLanguageList extends StatefulWidget {
  final Function(String locale) onLanguageSelected;
  final String selectedLocale;
  final EdgeInsets? listPadding;

  const SelectLanguageList({
    super.key,
    required this.selectedLocale,
    required this.onLanguageSelected,
    this.listPadding,
  });

  @override
  State<SelectLanguageList> createState() => _SelectLanguageListState();
}

class _SelectLanguageListState extends State<SelectLanguageList> {
  late List<LanguageInfo> languages;
  LanguageInfo? selectedLanguge;

  @override
  void initState() {
    languages = supportedLanguages;
    selectedLanguge = languages.byCode(widget.selectedLocale);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          density: TextFieldDensity.dense,
          prefixIcon: const Icon(BetterIcons.search01Filled),
          hint: context.strings.search,
          onChanged: (newValue) {
            setState(() {
              languages = supportedLanguages.search(newValue);
            });
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            padding: widget.listPadding ?? const EdgeInsets.only(bottom: 16),
            itemBuilder: (context, index) {
              final language = languages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: AppListItem(
                  isCompact: true,
                  actionType: ListItemActionType.radio,
                  isSelected: selectedLanguge == language,
                  onTap: (value) {
                    widget.onLanguageSelected(language.code);
                    setState(() {
                      selectedLanguge = language;
                    });
                  },
                  leading: Image.asset(
                    language.flagPath,
                    width: 32,
                    height: 32,
                    package: 'better_assets',
                  ),
                  title: language.name,
                  subtitle: language.code,
                ),
              );
            },
            separatorBuilder: (context, index) => const AppDivider(height: 16),
            itemCount: languages.length,
          ),
        ),
      ],
    );
  }
}
