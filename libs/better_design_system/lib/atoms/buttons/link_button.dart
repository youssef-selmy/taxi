import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
export 'button_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterLinkButton = AppLinkButton;

class AppLinkButton extends StatefulWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? text;
  final bool isLoading;
  final bool isDisabled;
  final void Function()? onPressed;
  final SemanticColor color;
  final ButtonSize size;

  final bool alwaysUnderline;

  const AppLinkButton({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.text,
    this.isLoading = false,
    this.isDisabled = false,
    required this.onPressed,
    this.color = SemanticColor.primary,
    this.size = ButtonSize.large,
    this.alwaysUnderline = false,
  });

  @override
  State<AppLinkButton> createState() => _AppLinkButtonState();
}

class _AppLinkButtonState extends State<AppLinkButton> {
  bool _isHovered = false;
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) => setState(() => _isHovered = value),
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      child: TextButton(
        onPressed: widget.isDisabled ? null : widget.onPressed,
        style: ButtonStyle(
          visualDensity: VisualDensity.standard,
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStatePropertyAll(context.colors.transparent),
          backgroundColor: WidgetStateColor.fromMap({
            WidgetState.any: context.colors.transparent,
          }),
          foregroundColor: WidgetStateColor.fromMap({
            WidgetState.pressed: widget.color.bold(context),
            WidgetState.hovered: widget.color.bold(context),
            WidgetState.any: _foregroundColor(context),
          }),
          side: const WidgetStateProperty.fromMap({
            WidgetState.any: BorderSide.none,
          }),
          textStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
            if (widget.alwaysUnderline ||
                (states.contains(WidgetState.hovered) &&
                    !states.contains(WidgetState.disabled))) {
              return _textStyle(context)?.apply(
                decoration: TextDecoration.underline,
                decorationColor: (_isHovered || _isPressed)
                    ? widget.color.bold(context)
                    : _foregroundColor(context),
                decorationStyle: TextDecorationStyle.solid,
              );
            }
            return _textStyle(context);
          }),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: widget.size == ButtonSize.small ? 4 : 8,
          children: [
            if (widget.isLoading)
              CupertinoActivityIndicator(color: _foregroundColor(context)),
            if (widget.prefixIcon != null && !widget.isLoading)
              Icon(
                widget.prefixIcon,
                size: widget.size.iconSize,
                color: _getIconColor(context),
              ),

            if (widget.text != null) Text(widget.text!),
            if (widget.suffixIcon != null && !widget.isLoading)
              Icon(
                widget.suffixIcon,
                size: widget.size.iconSize,
                color: _getIconColor(context),
              ),
          ],
        ),
      ),
    );
  }

  TextStyle? _textStyle(BuildContext context) =>
      widget.size.textStyle(context)?.apply(color: _foregroundColor(context));

  Color _foregroundColor(BuildContext context) => widget.isDisabled
      ? widget.color.disabled(context)
      : widget.color.main(context);

  Color _getIconColor(BuildContext context) {
    switch (_state) {
      case LinkButtonState.disabled:
        return widget.color.disabled(context);
      case LinkButtonState.hovered:
      case LinkButtonState.pressed:
        return widget.color.bold(context);

      case LinkButtonState.none:
        return widget.color.main(context);
    }
  }

  LinkButtonState get _state {
    if (widget.isDisabled) return LinkButtonState.disabled;
    if (_isHovered) return LinkButtonState.hovered;
    if (_isPressed) return LinkButtonState.pressed;

    return LinkButtonState.none;
  }
}

enum LinkButtonState { hovered, pressed, none, disabled }
