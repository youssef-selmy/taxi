import 'package:better_design_system/atoms/buttons/fab_size.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/colors/semantic_color.dart';
export 'fab_size.dart';

typedef BetterFloatingActionButton = AppFloatingActionButton;

class AppFloatingActionButton extends StatelessWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? text;
  final bool isLoading;
  final bool isDisabled;
  final void Function()? onPressed;
  final SemanticColor color;
  final FabSize size;
  final bool isFilled;

  const AppFloatingActionButton({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.text,
    this.isLoading = false,
    this.isDisabled = false,
    required this.onPressed,
    this.color = SemanticColor.primary,
    this.size = FabSize.large,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        visualDensity: VisualDensity.standard,
        minimumSize: const WidgetStatePropertyAll(Size.zero),
        padding: WidgetStatePropertyAll(size.padding(hasText: text != null)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStatePropertyAll(context.colors.transparent),
        backgroundColor: WidgetStateColor.fromMap({
          WidgetState.pressed: color.variant(context),
          WidgetState.hovered: color.containerColor(context),
          WidgetState.focused: color.variant(context),
          WidgetState.any: isFilled
              ? color.containerColor(context)
              : context.colors.surface,
        }),
        side: WidgetStateProperty.fromMap({
          WidgetState.hovered: isFilled
              ? BorderSide(color: color.variant(context), width: 1)
              : BorderSide.none,
          WidgetState.any: BorderSide.none,
        }),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          if (isLoading)
            CupertinoActivityIndicator(color: _foregroundColor(context)),
          if (prefixIcon != null && !isLoading)
            Icon(
              prefixIcon,
              size: size.iconSize(hasText: text != null),
              color: _foregroundColor(context),
            ),
          if (text != null)
            Text(
              text!,
              style: context.textTheme.labelMedium?.apply(
                color: _foregroundColor(context),
              ),
            ),
          if (suffixIcon != null)
            Icon(
              suffixIcon,
              size: size.iconSize(hasText: text != null),
              color: _foregroundColor(context),
            ),
        ],
      ),
    );
  }

  Color _foregroundColor(BuildContext context) => isDisabled
      ? (isFilled ? color.disabled(context) : context.colors.onSurfaceDisabled)
      : (isFilled ? color.main(context) : context.colors.onSurface);
}
