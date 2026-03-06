import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'icon_button.dart';

typedef BetterTopBarIconButton = AppTopBarIconButton;

class AppTopBarIconButton extends StatefulWidget {
  final IconData icon;
  final IconData? iconSelected;
  final bool isSelected;
  final SemanticColor color;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final int? badgeCount;
  final Color? iconColor;
  final IconButtonStyle style;

  const AppTopBarIconButton({
    super.key,
    required this.icon,
    this.iconSelected,
    this.isSelected = false,
    this.color = SemanticColor.neutral,
    this.isDisabled = false,
    this.onPressed,
    this.badgeCount,
    this.iconColor,
  }) : style = IconButtonStyle.ghost;

  const AppTopBarIconButton.outline({
    super.key,
    required this.icon,
    this.iconSelected,
    this.isSelected = false,
    this.color = SemanticColor.neutral,
    this.isDisabled = false,
    this.onPressed,
    this.badgeCount,
    this.iconColor,
  }) : style = IconButtonStyle.outline;

  @override
  State<AppTopBarIconButton> createState() => _AppTopBarIconButtonState();
}

class _AppTopBarIconButtonState extends State<AppTopBarIconButton> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  static const double _iconSize = 24.0;
  static const EdgeInsets _padding = EdgeInsets.all(8.0);
  static const BorderRadius _borderRadius = BorderRadius.all(
    Radius.circular(8.0),
  );

  void _handleTap() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    final colors = context.colors;

    if (widget.isSelected) {
      return widget.style == IconButtonStyle.outline
          ? context.colors.surfaceVariant
          : widget.color.containerColor(context);
    }

    if (widget.style == IconButtonStyle.ghost) {
      if (_isPressed) return colors.surfaceVariant;
      if (_isHovered || _isFocused) return colors.surfaceVariantLow;
      return context.colors.transparent;
    }

    if (_isPressed) return colors.surfaceVariant;
    if (_isHovered || _isFocused) return colors.surfaceVariantLow;
    return colors.surface;
  }

  Color _getForegroundColor(BuildContext context) {
    final colors = context.colors;

    if (widget.iconColor != null) {
      return widget.iconColor!;
    }

    if (widget.isSelected) {
      return context.colors.onSurface;
    }

    return colors.onSurfaceVariant;
  }

  BorderSide _getBorderSide(BuildContext context) {
    final colors = context.colors;

    if (widget.style == IconButtonStyle.ghost) {
      return BorderSide.none;
    }

    if (widget.isSelected) {
      return BorderSide(color: colors.outline, width: 1);
    }

    if (_isPressed) {
      return BorderSide(color: colors.outline, width: 1);
    }

    return BorderSide(color: colors.outline, width: 1);
  }

  @override
  Widget build(BuildContext context) {
    final currentBackgroundColor = _getBackgroundColor(context);
    final currentForegroundColor = _getForegroundColor(context);
    final currentBorderSide = _getBorderSide(context);

    final iconData = widget.isSelected && widget.iconSelected != null
        ? widget.iconSelected!
        : widget.icon;

    Widget iconWidget = Icon(
      iconData,
      size: _iconSize,
      color: currentForegroundColor,
    );

    Widget content = iconWidget;

    if (widget.badgeCount != null && widget.badgeCount! > 0) {
      content = Badge(
        label: Text(
          widget.badgeCount.toString(),
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.onError,
          ),
        ),
        backgroundColor: context.colors.error,
        alignment: Alignment.topRight,
        offset: const Offset(5, -5),
        child: content,
      );
    }

    return FocusableActionDetector(
      mouseCursor: widget.isDisabled
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,

      onShowHoverHighlight: (isHovered) =>
          setState(() => _isHovered = isHovered),
      onShowFocusHighlight: (isFocused) =>
          setState(() => _isFocused = isFocused),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: _handleTap,
        child: Container(
          padding: _padding,
          decoration: BoxDecoration(
            color: currentBackgroundColor,
            borderRadius: _borderRadius,
            border: Border.fromBorderSide(currentBorderSide),
          ),
          child: content,
        ),
      ),
    );
  }
}
