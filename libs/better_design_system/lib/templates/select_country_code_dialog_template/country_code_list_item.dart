import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/config/country_data.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

typedef BetterCountryCodeListItem = AppCountryCodeListItem;

class AppCountryCodeListItem extends StatelessWidget {
  final CountryInfo countryInfo;
  final Function(CountryInfo countryInfo) onPressed;
  final bool isSelected;

  const AppCountryCodeListItem({
    super.key,
    required this.countryInfo,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Image.asset(
              countryInfo.flagPath,
              width: 32,
              height: 32,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
              package: 'better_assets',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(countryInfo.name, style: context.textTheme.labelLarge),
                const SizedBox(height: 4),
                Text(
                  '+${countryInfo.dialCode}',
                  style: context.textTheme.bodySmall?.variant(context),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          AppRadio(
            groupValue: isSelected,
            value: true,
            size: RadioSize.small,
            onTap: (value) => onPressed(countryInfo),
          ),
        ],
      ),
      onPressed: () => onPressed(countryInfo),
    );
  }
}
