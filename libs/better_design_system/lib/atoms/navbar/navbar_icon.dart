import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterNavbarIcon = AppNavbarIcon;

class AppNavbarIcon extends StatefulWidget {
  const AppNavbarIcon({
    super.key,
    required this.icon,
    this.badgeNumber,
    this.isSelected = false,
    this.style = NavbarIconStyle.nuetral,
    this.onPressed,
    this.borderRadius,
    this.size = ButtonSize.medium,
    this.iconColor,
    this.iconSize,
  });

  final IconData icon;
  final bool isSelected;

  final int? badgeNumber;

  final NavbarIconStyle style;

  final void Function()? onPressed;

  final BorderRadius? borderRadius;

  final ButtonSize size;

  final Color? iconColor;

  final double? iconSize;

  @override
  State<AppNavbarIcon> createState() => _AppNavbarIconState();
}

class _AppNavbarIconState extends State<AppNavbarIcon> {
  bool _isHovered = false;
  bool _isPressed = false;

  Offset get _badgeOffset {
    switch (widget.size) {
      case ButtonSize.small:
        return const Offset(7, -4);
      case ButtonSize.medium:
        return const Offset(3, -3);
      case ButtonSize.large:
        return const Offset(3, -3);
      case ButtonSize.extraLarge:
        return const Offset(-4, -3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.colors.transparent,
      highlightColor: context.colors.transparent,
      hoverColor: context.colors.transparent,
      onHover: (value) => setState(() => _isHovered = value),
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      onTap: () {
        widget.onPressed?.call();
      },
      child: Badge(
        isLabelVisible: widget.badgeNumber != null && widget.badgeNumber! > 0,
        label: Text(widget.badgeNumber.toString()),
        offset: _badgeOffset,
        child: Container(
          padding: widget.size.padding,
          decoration: BoxDecoration(
            color: _getBackgroundColor(context),
            borderRadius: widget.borderRadius ?? widget.size.borderRadius,
            border: Border.all(color: context.colors.outline),
          ),
          child: Icon(
            widget.icon,
            size: widget.iconSize ?? widget.size.iconSize,
            color: _getForegroundColor(context),
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (widget.style) {
      case NavbarIconStyle.primary:
        if (widget.isSelected || _isPressed) {
          return context.colors.primaryContainer;
        } else if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else {
          return context.colors.surface;
        }
      case NavbarIconStyle.nuetral:
        if (widget.isSelected || _isPressed) {
          return context.colors.surfaceVariant;
        } else if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else {
          return context.colors.surface;
        }
    }
  }

  Color _getForegroundColor(BuildContext context) {
    if (widget.iconColor != null) {
      return widget.iconColor!;
    }

    switch (widget.style) {
      case NavbarIconStyle.primary:
        if (widget.isSelected || _isPressed) {
          return context.colors.primary;
        } else {
          return context.colors.onSurfaceVariant;
        }

      case NavbarIconStyle.nuetral:
        if (widget.isSelected || _isPressed) {
          return context.colors.onSurface;
        } else {
          return context.colors.onSurfaceVariant;
        }
    }
  }
}

enum NavbarIconStyle { nuetral, primary }
