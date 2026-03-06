import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/config/country_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

import 'country_code_list_item.dart';

typedef BetterCountryCodeList = AppCountryCodeList;

class AppCountryCodeList extends StatefulWidget {
  /// Called when a country is selected. Returns the ISO2 country code (e.g., "US").
  final Function(String) onChanged;

  const AppCountryCodeList({super.key, required this.onChanged});

  @override
  State<AppCountryCodeList> createState() => _AppCountryCodeListState();
}

class _AppCountryCodeListState extends State<AppCountryCodeList> {
  late List<CountryInfo> fullCountryCodes;
  List<CountryInfo> countryCodes = [];
  CountryInfo? selectedCountryCode;

  @override
  void initState() {
    fullCountryCodes = getAllCountries();
    countryCodes = fullCountryCodes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          density: TextFieldDensity.dense,
          onChanged: (newValue) {
            setState(() {
              countryCodes = searchCountries(newValue);
            });
          },
          prefixIcon: const Icon(BetterIcons.search01Filled),
          hint: context.strings.searchCountryName,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = countryCodes[index];
              return AppCountryCodeListItem(
                countryInfo: item,
                isSelected: selectedCountryCode == item,
                onPressed: (newValue) {
                  setState(() {
                    selectedCountryCode = newValue;
                  });
                  widget.onChanged(newValue.iso2Code);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 16),
            itemCount: countryCodes.length,
          ),
        ),
      ],
    );
  }
}
