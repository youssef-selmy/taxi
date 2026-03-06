import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/buttons/base_animated_button.dart';
import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

export 'button_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterOutlinedButton = AppOutlinedButton;

class AppOutlinedButton extends StatelessWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? child;

  final String? text;
  final bool isLoading;
  final bool isDisabled;
  final bool isSelected;
  final void Function()? onPressed;
  final SemanticColor color;
  final ButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final MainAxisAlignment alignment;
  final BorderRadius? borderRadius;

  const AppOutlinedButton({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.child,
    this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.isSelected = false,
    required this.onPressed,
    this.color = SemanticColor.neutral,
    this.size = ButtonSize.large,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.alignment = MainAxisAlignment.center,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAnimatedButton(
      isDisabled: isDisabled,
      onPressed: onPressed,
      builder: (context, state) {
        return Container(
          padding: size.padding,
          decoration: BoxDecoration(
            color: _getBackgroundColor(context, state),
            borderRadius: borderRadius ?? size.borderRadius,
            border: Border.all(
              color: _getBorderColor(context, state),
              width: 1,
            ),
          ),
          child: child != null
              ? DefaultTextStyle.merge(
                  style: TextStyle(color: _foregroundColor(context, state)),
                  child: child!,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: alignment,
                  spacing: size == ButtonSize.small ? 4 : 8,
                  children: [
                    if (isLoading)
                      CupertinoActivityIndicator(
                        color: _foregroundColor(context, state),
                      ),
                    if (prefix != null) prefix!,
                    if (prefixIcon != null && !isLoading)
                      Icon(
                        prefixIcon,
                        size: size.iconSize,
                        color: _foregroundColor(context, state),
                      ),
                    if (text != null)
                      Text(text!, style: _textStyle(context, state)),
                    if (suffixIcon != null)
                      Icon(
                        suffixIcon,
                        size: size.iconSize,
                        color: _foregroundColor(context, state),
                      ),
                    if (suffix != null && !isLoading) suffix!,
                  ],
                ),
        );
      },
    );
  }

  Color _getBackgroundColor(BuildContext context, ButtonState state) {
    if (state.isDisabled) {
      return backgroundColor ?? context.colors.surfaceMuted;
    }
    if (state.isPressed) {
      return backgroundColor ?? context.colors.surfaceVariant;
    }
    if (state.isHovered) {
      return backgroundColor ?? context.colors.surfaceVariantLow;
    }
    return backgroundColor ?? context.colors.surface;
  }

  Color _getBorderColor(BuildContext context, ButtonState state) {
    if (state.isDisabled) {
      return context.colors.outlineDisabled;
    }
    if (state.isPressed) {
      return color.main(context);
    }
    if (state.isFocused) {
      return context.colors.outline;
    }
    return borderColor ?? context.colors.outline;
  }

  TextStyle? _textStyle(BuildContext context, ButtonState state) =>
      size.textStyle(context)?.apply(color: _foregroundColor(context, state));

  Color _foregroundColor(BuildContext context, ButtonState state) =>
      state.isDisabled
      ? context.colors.onSurfaceDisabled
      : foregroundColor ?? color.main(context);
}
