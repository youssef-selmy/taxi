import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

export 'package:better_design_system/atoms/buttons/button_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

enum BorderedToggleButtonState { normal, hovered, pressed, active }

enum BorderedToggleButtonStyle { outline, soft }

/// A toggle button with bordered styling that adapts its appearance
/// based on different interaction states and styles.
typedef BetterBorderedToggleButton = AppBorderedToggleButton;

class AppBorderedToggleButton extends StatefulWidget {
  final String label;
  final IconData? prefixIcon;
  final bool isSelected;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final bool isDisabled;
  final bool isPillShaped;
  final BorderedToggleButtonStyle style;
  final SemanticColor color;

  const AppBorderedToggleButton({
    super.key,
    required this.label,
    this.prefixIcon,
    required this.isSelected,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.isDisabled = false,
    this.isPillShaped = true,
    this.style = BorderedToggleButtonStyle.outline,
    this.color = SemanticColor.neutral,
  });

  @override
  State<AppBorderedToggleButton> createState() =>
      _AppBorderedToggleButtonState();
}

class _AppBorderedToggleButtonState extends State<AppBorderedToggleButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  /// Determines the current state based on selection, hover, and press.
  BorderedToggleButtonState _getCoreState() {
    if (widget.isSelected) return BorderedToggleButtonState.active;
    if (_isPressed) return BorderedToggleButtonState.pressed;
    if (_isHovered) return BorderedToggleButtonState.hovered;
    return BorderedToggleButtonState.normal;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor(context);
    final foregroundColor = _getForegroundColor(context);
    final borderSide = _getBorderSide(context);
    final effectiveTextStyle = widget.size
        .textStyle(context)
        ?.copyWith(color: foregroundColor);
    final iconTextGap = widget.size == ButtonSize.small ? 4.0 : 8.0;
    final borderRadius = widget.isPillShaped
        ? BorderRadius.circular(100)
        : BorderRadius.circular(8);
    final cursor = widget.isDisabled || widget.onPressed == null
        ? null
        : SystemMouseCursors.click;

    return Material(
      // Set Material color to transparent so the background is drawn by AnimatedContainer.
      color: context.colors.transparent,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        mouseCursor: cursor,
        borderRadius: borderRadius,
        onHover: widget.isDisabled
            ? null
            : (hovering) => setState(() => _isHovered = hovering),
        onHighlightChanged: widget.isDisabled
            ? null
            : (pressed) => setState(() => _isPressed = pressed),
        onTap: widget.isDisabled ? null : widget.onPressed,
        splashColor: context.colors.transparent,
        highlightColor: context.colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: widget.size.padding,
          decoration: BoxDecoration(
            // Apply the background color here.
            color: backgroundColor,
            border: borderSide.width > 0
                ? Border.fromBorderSide(borderSide)
                : null,
            borderRadius: borderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.prefixIcon != null) ...[
                Icon(
                  widget.prefixIcon,
                  size: widget.size.iconSize,
                  color: foregroundColor,
                ),
                SizedBox(width: iconTextGap),
              ],
              Text(widget.label, style: effectiveTextStyle),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    final colors = context.colors;
    final coreState = _getCoreState();

    if (widget.isDisabled) return colors.surfaceVariantLow.withAlpha(75);

    switch (widget.style) {
      case BorderedToggleButtonStyle.outline:
        return switch (coreState) {
          BorderedToggleButtonState.active => widget.color.containerColor(
            context,
          ),
          BorderedToggleButtonState.pressed => colors.surfaceVariant,
          BorderedToggleButtonState.hovered => colors.surfaceVariantLow,
          BorderedToggleButtonState.normal => colors.surface,
        };
      case BorderedToggleButtonStyle.soft:
        return switch (coreState) {
          BorderedToggleButtonState.active => widget.color.main(context),
          BorderedToggleButtonState.pressed => context.colors.surfaceVariant,
          BorderedToggleButtonState.hovered => context.colors.surfaceContainer,
          BorderedToggleButtonState.normal => context.colors.surfaceContainer,
        };
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final colors = context.colors;
    final coreState = _getCoreState();

    if (widget.isDisabled) return colors.onSurfaceDisabled;

    switch (widget.style) {
      case BorderedToggleButtonStyle.outline:
        return switch (coreState) {
          BorderedToggleButtonState.active => widget.color.main(context),
          BorderedToggleButtonState.pressed => colors.onSurface,
          BorderedToggleButtonState.hovered => colors.onSurface,
          BorderedToggleButtonState.normal => colors.onSurfaceVariant,
        };
      case BorderedToggleButtonStyle.soft:
        return switch (coreState) {
          BorderedToggleButtonState.active => widget.color.onColor(context),
          BorderedToggleButtonState.pressed => colors.onSurface,
          BorderedToggleButtonState.hovered => colors.onSurface,
          BorderedToggleButtonState.normal => colors.onSurfaceVariant,
        };
    }
  }

  BorderSide _getBorderSide(BuildContext context) {
    final colors = context.colors;
    final coreState = _getCoreState();

    if (widget.isDisabled) {
      return widget.style == BorderedToggleButtonStyle.outline
          ? BorderSide(color: colors.outlineDisabled, width: 1)
          : BorderSide.none;
    }

    switch (widget.style) {
      case BorderedToggleButtonStyle.outline:
        return switch (coreState) {
          BorderedToggleButtonState.active => BorderSide(
            color: widget.color.main(context),
            width: 1,
          ),
          BorderedToggleButtonState.pressed => BorderSide(
            color: colors.outlineVariant,
            width: 1,
          ),
          BorderedToggleButtonState.hovered => BorderSide(
            color: colors.outline,
            width: 1,
          ),
          BorderedToggleButtonState.normal => BorderSide(
            color: colors.outline,
            width: 1,
          ),
        };
      case BorderedToggleButtonStyle.soft:
        return BorderSide.none;
    }
  }
}
