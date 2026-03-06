import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/buttons/base_animated_button.dart';
import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

export 'button_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterFilledButton = AppFilledButton;

class AppFilledButton extends StatelessWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? child;
  final String? text;
  final bool isLoading;
  final bool isDisabled;
  final BorderRadius? borderRadius;
  final void Function()? onPressed;
  final SemanticColor color;
  final ButtonSize size;

  const AppFilledButton({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.child,
    this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.borderRadius,
    required this.onPressed,
    this.color = SemanticColor.primary,
    this.size = ButtonSize.large,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isDisabled ? 0.8 : 1,
      child: BaseAnimatedButton(
        isDisabled: isDisabled,
        onPressed: onPressed,
        builder: (context, state) {
          return Container(
            padding: size.padding,
            decoration: BoxDecoration(
              color: _getBackgroundColor(context, state),
              borderRadius: borderRadius ?? size.borderRadius,
              border: (state.isHovered || state.isFocused) && !state.isDisabled
                  ? Border.all(
                      color: color.variantLow(context),
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    )
                  : null,
            ),
            child: child != null
                ? DefaultTextStyle.merge(
                    style: TextStyle(color: _foregroundColor(context)),
                    child: Center(child: child!),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: size == ButtonSize.small ? 4 : 8,
                    children: [
                      if (isLoading)
                        CupertinoActivityIndicator(
                          radius: size.iconSize / 2,
                          color: _foregroundColor(context),
                        ),
                      if (prefixIcon != null && !isLoading)
                        Icon(
                          prefixIcon,
                          size: size.iconSize,
                          color: _foregroundColor(context),
                        ),
                      if (text != null) Text(text!, style: _textStyle(context)),
                      if (suffixIcon != null)
                        Icon(
                          suffixIcon,
                          size: size.iconSize,
                          color: _foregroundColor(context),
                        ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context, ButtonState state) {
    if (state.isDisabled) return color.disabled(context);
    if (state.isPressed) return color.bold(context);
    return color.main(context);
  }

  TextStyle? _textStyle(BuildContext context) =>
      size.textStyle(context)?.apply(color: _foregroundColor(context));

  Color _foregroundColor(BuildContext context) => color.onColor(context);
}
