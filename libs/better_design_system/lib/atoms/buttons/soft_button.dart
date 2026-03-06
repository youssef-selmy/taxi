import 'package:better_design_system/atoms/buttons/base_animated_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/buttons/button_size.dart';

export 'button_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterSoftButton = AppSoftButton;

class AppSoftButton extends StatelessWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? text;
  final bool isLoading;
  final bool isDisabled;
  final void Function()? onPressed;
  final SemanticColor color;
  final ButtonSize size;
  final EdgeInsets? padding;

  const AppSoftButton({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.text,
    this.isLoading = false,
    this.isDisabled = false,
    required this.onPressed,
    this.color = SemanticColor.primary,
    this.size = ButtonSize.large,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAnimatedButton(
      isDisabled: isDisabled,
      onPressed: onPressed,
      builder: (context, state) {
        return Container(
          padding: padding ?? size.padding,
          decoration: BoxDecoration(
            color: _getBackgroundColor(context, state),
            borderRadius: size.borderRadius,
            border: _getBorder(context, state),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: size == ButtonSize.small ? 4 : 8,
            children: [
              if (isLoading)
                CupertinoActivityIndicator(
                  color: _foregroundColor(context, state),
                ),
              if (prefixIcon != null && !isLoading)
                Icon(
                  prefixIcon,
                  size: size.iconSize,
                  color: _foregroundColor(context, state),
                ),
              if (text != null) Text(text!, style: _textStyle(context, state)),
              if (suffixIcon != null)
                Icon(
                  suffixIcon,
                  size: size.iconSize,
                  color: _foregroundColor(context, state),
                ),
            ],
          ),
        );
      },
    );
  }

  Color _getBackgroundColor(BuildContext context, ButtonState state) {
    if (state.isDisabled) return context.colors.surfaceMuted;
    if (state.isPressed) return color.variant(context);
    if (state.isFocused || state.isHovered) return context.colors.surface;
    return color.containerColor(context);
  }

  Border? _getBorder(BuildContext context, ButtonState state) {
    if (state.isPressed) {
      return Border.all(color: color.main(context), width: 1);
    }
    if (state.isHovered) {
      return Border.all(color: color.variant(context), width: 1);
    }
    return null;
  }

  TextStyle? _textStyle(BuildContext context, ButtonState state) =>
      size.textStyle(context)?.apply(color: _foregroundColor(context, state));

  Color _foregroundColor(BuildContext context, ButtonState state) =>
      state.isDisabled ? context.colors.onSurfaceDisabled : color.main(context);
}
