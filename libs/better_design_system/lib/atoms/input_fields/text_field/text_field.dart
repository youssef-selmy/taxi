import 'package:better_design_system/atoms/input_fields/base_components/input_label.dart';
import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../base_components/input_hint.dart';

export 'package:better_design_system/atoms/input_fields/text_field_density.dart';

typedef BetterTextField = AppTextField;

class AppTextField extends StatefulWidget {
  final String? label;
  final String? sublabel;
  final String? labelHelpText;
  final bool isRequired;
  final String? hint;
  final String? helpText;
  final SemanticColor helpTextColor;
  final String? initialValue;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final bool isFilled;
  final TextFieldDensity density;
  final bool showEditButton;
  final bool isDisabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final EdgeInsets? iconPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? constraints;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final Function()? onFocused;
  final Function()? onUnfocused;
  final FocusNode? focusNode;
  final bool readOnly;
  final TextAlign textAlign;
  final Color? fillColor;
  final BorderRadius borderRadius;
  final String? errorText;
  final Iterable<String>? autofillHints;
  final bool autofocus;

  const AppTextField({
    super.key,
    this.label,
    this.sublabel,
    this.labelHelpText,
    this.isRequired = false,
    this.hint,
    this.helpText,
    this.helpTextColor = SemanticColor.neutral,
    this.initialValue,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.isFilled = true,
    this.fillColor,
    this.density = TextFieldDensity.responsive,
    this.showEditButton = false,
    this.isDisabled = false,
    this.inputFormatters,
    this.controller,
    this.iconPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.constraints,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.onChanged,
    this.onFocused,
    this.onUnfocused,
    this.focusNode,
    this.readOnly = false,
    this.textAlign = TextAlign.start,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.errorText,
    this.autofillHints,
    this.autofocus = false,
  });

  @override
  createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode focusNode;
  bool isEditing = false;
  late bool isEnabled;
  String? text;
  final GlobalKey<FormFieldState<String>> _textFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(() {
      setState(() {});
      if (focusNode.hasFocus) {
        widget.onFocused?.call();
      } else {
        widget.onUnfocused?.call();
      }
    });
    isEnabled = widget.showEditButton ? false : true;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.constraints,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            AppInputLabel(
              label: widget.label!,
              sublabel: widget.sublabel,
              isRequired: widget.isRequired,
              helpText: widget.labelHelpText,
            ),
            const SizedBox(height: 8),
          ],
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: widget.borderRadius,
              boxShadow:
                  focusNode.hasFocus &&
                      !context.isDark &&
                      !widget.isDisabled &&
                      widget.errorText == null &&
                      !(_textFieldKey.currentState?.hasError ?? false)
                  ? [
                      BoxShadow(
                        color: context.colors.primaryContainer,
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
            child: TextFormField(
              key: _textFieldKey,
              enabled: !widget.isDisabled,
              onSaved: widget.onSaved,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              textAlign: widget.textAlign,
              readOnly: widget.readOnly ? true : !isEnabled,
              focusNode: focusNode,
              autofocus: widget.autofocus,
              errorBuilder: (context, errorText) {
                final displayError = widget.errorText ?? errorText;
                return Text(
                  displayError,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.error,
                  ),
                );
              },
              controller: widget.controller,
              initialValue: widget.initialValue,
              autofillHints: widget.autofillHints,
              obscureText: widget.obscureText,
              keyboardType: widget.maxLines > 1
                  ? TextInputType.multiline
                  : widget.keyboardType,
              textInputAction: widget.maxLines > 1
                  ? TextInputAction.newline
                  : widget.textInputAction,
              maxLines: widget.maxLines,
              style: context.textTheme.labelLarge?.copyWith(
                color: widget.isDisabled
                    ? context.colors.onSurfaceDisabled
                    : context.colors.onSurface,
              ),
              inputFormatters: widget.inputFormatters,
              onChanged: (value) {
                widget.onChanged?.call(value);
                setState(() {
                  text = value;
                });
              },

              decoration: InputDecoration(
                errorText: widget.errorText,
                hintText: widget.hint,
                isDense: widget.density == TextFieldDensity.noDense,
                enabledBorder: widget.isFilled
                    ? OutlineInputBorder(
                        borderRadius: widget.borderRadius,
                        borderSide: BorderSide(
                          color: context.colors.surfaceVariant,
                          width: 1,
                        ),
                      )
                    : OutlineInputBorder(
                        borderRadius: widget.borderRadius,
                        borderSide: BorderSide(
                          color: context.colors.outline,
                          width: 1,
                        ),
                      ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: BorderSide(
                    color: context.colors.outlineVariant,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: BorderSide(
                    color: context.colors.primary,
                    width: 1.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: BorderSide(
                    color: context.colors.error,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius,
                  borderSide: BorderSide(color: context.colors.error, width: 2),
                ),
                hintStyle: _hintStyle(context),
                filled: widget.isFilled,

                contentPadding: widget.density.padding(context),
                suffix: widget.showEditButton
                    ? CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        onPressed: () {
                          if (isEditing) {
                            setState(() {
                              isEnabled = false;
                              isEditing = false;
                            });
                            widget.onFieldSubmitted?.call(text ?? "");
                          } else {
                            setState(() {
                              isEnabled = true;
                              isEditing = true;
                            });
                            focusNode.requestFocus();
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
                fillColor: widget.isFilled
                    ? (widget.fillColor ??
                          context.theme.inputDecorationTheme.fillColor)
                    : null,
                prefixIcon: widget.prefixIcon == null
                    ? null
                    : Padding(
                        padding:
                            widget.iconPadding ??
                            widget.density.padding(context),
                        child: widget.prefixIcon,
                      ),
                suffixIcon: widget.suffixIcon == null
                    ? null
                    : Padding(
                        padding:
                            widget.iconPadding ??
                            widget.density.padding(context),
                        child: widget.suffixIcon,
                      ),
              ),
            ),
          ),
          if (widget.helpText != null) ...[
            const SizedBox(height: 8),
            AppInputHint(text: widget.helpText!, color: widget.helpTextColor),
          ],
        ],
      ),
    );
  }

  TextStyle? _hintStyle(BuildContext context) {
    return _isDense(context)
        ? context.textTheme.bodyMedium?.variant(context)
        : context.theme.inputDecorationTheme.hintStyle;
  }

  bool _isDense(BuildContext context) =>
      widget.density.resolveDensity(context) == TextFieldDensity.dense;
}
