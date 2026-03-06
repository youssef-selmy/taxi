import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'country_code_list.dart';

typedef BetterSelectCountryCodeDialog = AppSelectCountryCodeDialog;

class AppSelectCountryCodeDialog extends StatefulWidget {
  /// Initial country code (ISO2 format, e.g., "US", "GB")
  final String? initialCountryCode;

  const AppSelectCountryCodeDialog({super.key, this.initialCountryCode});

  @override
  State<AppSelectCountryCodeDialog> createState() =>
      _AppSelectCountryCodeDialogState();
}

class _AppSelectCountryCodeDialogState
    extends State<AppSelectCountryCodeDialog> {
  String? selectedCountryCode;

  @override
  void initState() {
    super.initState();
    selectedCountryCode = widget.initialCountryCode;
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      defaultDialogType: DialogType.fullScreenBottomSheet,
      desktopDialogType: DialogType.dialog,
      onClosePressed: () => Navigator.of(context).pop(),
      icon: BetterIcons.flag02Filled,
      title: context.strings.selectCountryCode,
      child: SizedBox(
        height: context.isDesktop ? 400 : null,
        child: AppCountryCodeList(
          onChanged: (countryCode) {
            Navigator.of(context).pop(countryCode);
          },
        ),
      ),
    );
  }
}
