import 'package:better_design_system/atoms/input_fields/base_components/input_label.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/config/country_data.dart';
import 'package:better_design_system/templates/select_country_code_dialog_template/select_country_code_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/utils/phone_number_parser.dart';
import 'package:better_icons/better_icons.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef BetterPhoneNumberField = AppPhoneNumberField;

class AppPhoneNumberField extends StatefulWidget {
  /// Called when the country code or phone number changes.
  /// The tuple contains (ISO2 country code, phone number).
  /// Example: ("US", "5551234567")
  final Function((String, String?)?)? onChanged;

  /// Called when the form is saved with the current value.
  final Function((String, String?)?)? onSaved;

  /// Called when the user submits the phone number field.
  final Function((String, String?)?)? onFieldSubmitted;

  /// Initial value as a tuple of (ISO2 country code, phone number).
  /// Example: ("GB", "2012345678")
  final (String, String?) initialValue;

  /// Validator function for the phone number field.
  final String? Function((String, String?)?)? validator;
  final String? errorText;
  final String? label;
  final String? sublabel;
  final bool isRequired;
  final String? hint;
  final String? helpText;
  final SemanticColor helpTextColor;
  final TextFieldDensity density;
  final bool isFilled;
  final bool showEditButton;

  const AppPhoneNumberField({
    super.key,
    required this.initialValue,
    this.onChanged,
    this.validator,
    this.errorText,
    this.onSaved,
    this.onFieldSubmitted,
    this.label,
    this.sublabel,
    this.isRequired = false,
    this.hint,
    this.helpText,
    this.density = TextFieldDensity.responsive,
    this.helpTextColor = SemanticColor.neutral,
    this.isFilled = true,
    this.showEditButton = false,
  });

  @override
  State<AppPhoneNumberField> createState() => _AppPhoneNumberFieldState();
}

class _AppPhoneNumberFieldState extends State<AppPhoneNumberField> {
  late bool isEditing;
  late bool isEnabled;
  TextEditingController? _textController;
  String? _previousPhoneNumber;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.showEditButton ? false : true;
    isEditing = false;
    _textController = TextEditingController(text: widget.initialValue.$2);
    _previousPhoneNumber = widget.initialValue.$2;
  }

  @override
  void dispose() {
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<(String, String?)>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      onSaved: widget.onSaved,
      builder: (state) {
        final countryInfo = countryData[state.value!.$1];
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.label != null) ...[
              AppInputLabel(
                label: widget.label!,
                sublabel: widget.sublabel,
                isRequired: widget.isRequired,
              ),
              const SizedBox(height: 8),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: isEnabled
                      ? () async {
                          final countryCodeDialogResult =
                              await showDialog<String>(
                                context: context,
                                useSafeArea: false,
                                builder: (context) =>
                                    const AppSelectCountryCodeDialog(),
                              );
                          if (countryCodeDialogResult != null) {
                            state.didChange((
                              countryCodeDialogResult,
                              state.value!.$2,
                            ));
                            widget.onChanged?.call((
                              countryCodeDialogResult,
                              state.value!.$2,
                            ));
                            _previousPhoneNumber = state.value!.$2;
                          }
                        }
                      : null,
                  minimumSize: const Size(0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    padding: const EdgeInsets.all(13),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          countryInfo!.flagPath,
                          width: 20,
                          height: 20,
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                          package: 'better_assets',
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '+${countryInfo.dialCode}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: AppTextField(
                    hint: widget.hint,
                    isFilled: widget.isFilled,
                    helpText: widget.helpText,
                    helpTextColor: widget.helpTextColor,
                    iconPadding: const EdgeInsets.all(0),
                    keyboardType: TextInputType.phone,
                    autofillHints: [AutofillHints.telephoneNumber],
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _textController,
                    readOnly: !isEnabled,
                    suffixIcon: widget.showEditButton
                        ? CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            onPressed: () {
                              if (isEditing) {
                                setState(() {
                                  isEnabled = false;
                                  isEditing = false;
                                });
                                widget.onFieldSubmitted?.call(state.value);
                              } else {
                                setState(() {
                                  isEnabled = true;
                                  isEditing = true;
                                });
                              }
                            },
                            minimumSize: const Size(0, 0),
                            child: isEditing
                                ? Icon(
                                    BetterIcons.tick02Outline,
                                    color: context.colors.onSurfaceVariant,
                                    size: 20,
                                  )
                                : Icon(
                                    BetterIcons.pencilEdit02Filled,
                                    color: context.colors.onSurfaceVariant,
                                    size: 20,
                                  ),
                          )
                        : null,
                    onChanged: (value) {
                      // Check for autofill
                      if (isLikelyAutofill(_previousPhoneNumber, value)) {
                        final parsed = parseAutofillPhoneNumber(value);
                        if (parsed != null) {
                          // Update country dropdown
                          state.didChange((
                            parsed.iso2Code,
                            parsed.nationalNumber,
                          ));

                          // Update text field (strip country code)
                          _textController?.text = parsed.nationalNumber;
                          _textController?.selection = TextSelection.collapsed(
                            offset: parsed.nationalNumber.length,
                          );

                          // Notify parent with parsed values
                          widget.onChanged?.call((
                            parsed.iso2Code,
                            parsed.nationalNumber,
                          ));
                          _previousPhoneNumber = parsed.nationalNumber;
                          return;
                        }
                      }

                      // Normal flow - no autofill detected
                      state.didChange((state.value!.$1, value));
                      widget.onChanged?.call((state.value!.$1, value));
                      _previousPhoneNumber = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
