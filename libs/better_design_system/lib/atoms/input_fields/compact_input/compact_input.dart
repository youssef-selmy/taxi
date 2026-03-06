import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
export 'package:better_design_system/atoms/input_fields/text_field_density.dart';

typedef BetterCompactInput = AppCompactInput;

class AppCompactInput extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isDisabled;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? constraints;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Function()? onFocused;
  final Function()? onUnfocused;
  final void Function(String)? onTextSubmitted;
  final List<String>? autofillHints;

  const AppCompactInput({
    super.key,
    this.initialValue,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isDisabled = false,
    this.inputFormatters,
    this.controller,
    this.autofillHints,
    this.prefixIcon,
    this.suffixIcon,
    this.constraints,
    this.validator,

    this.onChanged,
    this.onFocused,
    this.onUnfocused,
    this.onTextSubmitted,
  });

  @override
  createState() => _AppCompactInputState();
}

class _AppCompactInputState extends State<AppCompactInput> {
  FocusNode focusNode = FocusNode();
  bool isEditing = false;

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    focusNode.addListener(() {
      setState(() {});
      if (focusNode.hasFocus) {
        widget.onFocused?.call();
      } else {
        widget.onUnfocused?.call();
      }
    });
  }

  String? previousValue;

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },
      child: Container(
        padding: EdgeInsets.zero,
        constraints: widget.constraints,
        child: FormField(
          enabled: !widget.isDisabled,
          initialValue: widget.initialValue,
          validator: widget.validator,
          builder: (state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: (focusNode.hasFocus && isEditing)
                    ? context.colors.surface
                    : null,
              ),
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                autofillHints: widget.autofillHints,
                readOnly: !isEditing,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: _getTextColor(context),
                ),
                inputFormatters: widget.inputFormatters,
                onChanged: (value) {
                  state.didChange(value);
                  widget.onChanged?.call(value);
                },
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  isDense: true,
                  contentPadding: isEditing
                      ? const EdgeInsets.symmetric(horizontal: 8)
                      : const EdgeInsets.all(0),
                  hoverColor: state.hasError || widget.isDisabled
                      ? context.colors.transparent
                      : isEditing
                      ? context.colors.surface
                      : context.colors.surfaceVariant,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder:
                      (focusNode.hasFocus && isEditing && !state.hasError)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: context.colors.primary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        )
                      : OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                  filled: false,
                  fillColor: state.hasError
                      ? context.colors.errorVariantLow
                      : context.colors.transparent,
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          size: 20,
                          color: _getIconColor(context),
                        )
                      : null,

                  suffixIcon: isEditing
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              splashColor: context.colors.transparent,
                              hoverColor: context.colors.transparent,
                              child: Icon(
                                BetterIcons.cancel01Outline,
                                size: 20,
                                color: context.colors.onSurface,
                              ),
                              onTap: () {
                                setState(() {
                                  isEditing = false;
                                  controller.text = previousValue ?? '';
                                });
                                focusNode.unfocus();
                                widget.onTextSubmitted?.call(
                                  previousValue ?? '',
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              splashColor: context.colors.transparent,
                              hoverColor: context.colors.transparent,
                              child: Icon(
                                BetterIcons.tick02Outline,
                                size: 20,
                                color: context.colors.onSurface,
                              ),
                              onTap: () {
                                setState(() {
                                  isEditing = false;
                                });
                                focusNode.unfocus();
                                widget.onTextSubmitted?.call(controller.text);
                              },
                            ),
                            const SizedBox(width: 12),
                          ],
                        )
                      : widget.onTextSubmitted == null
                      ? null
                      : InkWell(
                          splashColor: context.colors.transparent,
                          hoverColor: context.colors.transparent,
                          onTap: widget.isDisabled
                              ? null
                              : () {
                                  setState(() {
                                    isEditing = true;
                                    previousValue = controller.text;
                                  });
                                  focusNode.requestFocus();
                                },
                          child: Icon(
                            BetterIcons.pencilEdit02Outline,
                            size: 20,
                            color: widget.isDisabled
                                ? context.colors.onSurfaceDisabled
                                : context.colors.onSurfaceVariant,
                          ),
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getIconColor(BuildContext context) {
    if (widget.isDisabled) {
      return context.colors.onSurfaceDisabled;
    }
    if (isHover) {
      return context.colors.onSurface;
    }
    if (isEditing) {
      return context.colors.onSurface;
    } else {
      return context.colors.onSurfaceVariant;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (widget.isDisabled) {
      return context.colors.onSurfaceDisabled;
    }
    if (isEditing) {
      return context.colors.onSurface;
    } else {
      return context.colors.onSurfaceVariant;
    }
  }
}
