import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'package:better_icons/better_icons.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

typedef BetterEnterGiftCodeDialogTemplate = AppEnterGiftCodeDialogTemplate;

class AppEnterGiftCodeDialogTemplate extends StatefulWidget {
  /// A callback function to validate the gift code. It should return
  /// null if the code is valid, or an error message string if invalid.
  final Future<String?> Function(String) validateCode;

  const AppEnterGiftCodeDialogTemplate({super.key, required this.validateCode});

  @override
  State<AppEnterGiftCodeDialogTemplate> createState() =>
      _AppEnterGiftCodeDialogTemplateState();
}

class _AppEnterGiftCodeDialogTemplateState
    extends State<AppEnterGiftCodeDialogTemplate> {
  String? _giftCardCode;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      title: context.strings.redeemGiftCard,
      subtitle: context.strings.redeemGiftCardDescription,
      icon: BetterIcons.giftFilled,
      iconColor: SemanticColor.primary,
      onClosePressed: () {
        Navigator.of(context).pop();
      },
      iconStyle: context.isDesktop
          ? DialogHeaderIconStyle.withBorder
          : DialogHeaderIconStyle.expanded,
      primaryButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: AppFilledButton(
          isDisabled: (_giftCardCode?.isEmpty ?? true) || _isLoading,
          isLoading: _isLoading,
          onPressed: () async {
            if (_giftCardCode?.isEmpty ?? true) return;
            setState(() {
              _isLoading = true;
            });
            final result = await widget.validateCode.call(_giftCardCode!);
            setState(() {
              _isLoading = false;
            });
            if (result == null) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop(result);
            }
            if (result != null) {
              setState(() {
                _errorMessage = result;
                _giftCardCode = null;
              });
            }
          },
          text: context.strings.redeem,
        ),
      ),
      secondaryButton: AppTextButton(
        isDisabled: _isLoading,
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: context.strings.cancel,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: AppTextField(
          hint: context.strings.enterGiftCardCode,
          helpText: _errorMessage,
          helpTextColor: SemanticColor.error,
          prefixIcon: const Icon(BetterIcons.giftOutline),
          onChanged: (value) {
            setState(() {
              _giftCardCode = value;
              _errorMessage = null;
            });
          },
        ),
      ),
    );
  }
}
