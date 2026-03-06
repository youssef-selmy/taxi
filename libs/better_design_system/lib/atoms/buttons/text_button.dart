import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/base_animated_button.dart';
import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

export 'button_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterTextButton = AppTextButton;

class AppTextButton extends StatelessWidget {
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final IconData? suffixIcon;
  final String? text;
  final bool isLoading;
  final bool isDisabled;
  final void Function()? onPressed;
  final SemanticColor color;
  final ButtonSize size;
  final int? badgeCount;

  const AppTextButton({
    super.key,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.suffixIcon,
    this.text,
    this.isLoading = false,
    this.isDisabled = false,
    required this.onPressed,
    this.badgeCount,
    this.color = SemanticColor.neutral,
    this.size = ButtonSize.large,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text('${badgeCount ?? 0}'),
      isLabelVisible: badgeCount != null && badgeCount! > 0,
      backgroundColor: context.colors.error,
      child: BaseAnimatedButton(
        isDisabled: isDisabled,
        onPressed: onPressed,
        builder: (context, state) {
          return Container(
            padding: size.padding,
            decoration: BoxDecoration(
              color: _getBackgroundColor(context, state),
              borderRadius: size.borderRadius,
              border: _getBorder(context, state),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
                if (suffix != null) suffix!,
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context, ButtonState state) {
    if (state.isDisabled) {
      return context.colors.transparent;
    }
    if (state.isPressed) {
      return color.containerColor(context);
    }
    if (state.isFocused) {
      return color.variant(context);
    }
    if (state.isHovered) {
      return color.containerColor(context);
    }
    return context.colors.transparent;
  }

  Border? _getBorder(BuildContext context, ButtonState state) {
    if (state.isPressed) {
      return Border.all(color: color.main(context), width: 1);
    }
    return Border.all(color: context.colors.transparent, width: 1);
  }

  TextStyle? _textStyle(BuildContext context, ButtonState state) =>
      size.textStyle(context)?.apply(color: _foregroundColor(context, state));

  Color _foregroundColor(BuildContext context, ButtonState state) =>
      state.isDisabled ? context.colors.onSurfaceDisabled : color.main(context);
}
