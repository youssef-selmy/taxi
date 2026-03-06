import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';

import 'package:flutter/material.dart';

typedef BetterNavbarActionItem = AppNavbarActionItem;

class AppNavbarActionItem extends StatefulWidget {
  const AppNavbarActionItem({
    super.key,
    this.title,
    required this.icon,
    this.badgeTitle,
    this.badgeNumber,
    this.style = NavbarActionItemStyle.nuetral,
    this.onPressed,
    this.isSelected = false,
    this.hasChevron = false,
  });

  final String? title;
  final IconData icon;
  final String? badgeTitle;
  final int? badgeNumber;
  final NavbarActionItemStyle style;
  final bool isSelected;
  final bool hasChevron;

  final void Function()? onPressed;
  @override
  State<AppNavbarActionItem> createState() => _AppNavbarActionItemState();
}

class _AppNavbarActionItemState extends State<AppNavbarActionItem> {
  bool _isHovered = false;

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      splashFactory: NoSplash.splashFactory,
      onHover: (value) => setState(() => _isHovered = value),
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      onTap: () => widget.onPressed?.call(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBackgroundColor(context),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: <Widget>[
            Icon(widget.icon, color: _getForegroundColor(context), size: 20),
            if (widget.title != null) ...[
              Text(
                widget.title!,
                style: context.textTheme.labelLarge?.copyWith(
                  color: _getForegroundColor(context),
                ),
              ),
            ],
            if (widget.badgeTitle != null) ...[
              AppBadge(
                text: widget.badgeTitle!,
                color: SemanticColor.warning,
                style: BadgeStyle.soft,
                isRounded: true,
              ),
            ],

            if (widget.badgeNumber != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: context.colors.error,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  widget.badgeNumber.toString(),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colors.onError,
                  ),
                ),
              ),
            ],

            if (widget.hasChevron)
              Icon(
                BetterIcons.arrowRight01Outline,
                size: 20,
                color: _getForegroundColor(context),
              ),
          ],
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (widget.style) {
      case NavbarActionItemStyle.primary:
        if (widget.isSelected) {
          return context.colors.primaryContainer;
        }
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else if (_isPressed) {
          return context.colors.primaryContainer;
        } else {
          return context.colors.surface;
        }
      case NavbarActionItemStyle.nuetral:
        if (widget.isSelected) {
          return context.colors.surfaceVariant;
        }
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else if (_isPressed) {
          return context.colors.surfaceVariant;
        } else {
          return context.colors.surface;
        }
    }
  }

  Color _getForegroundColor(BuildContext context) {
    switch (widget.style) {
      case NavbarActionItemStyle.primary:
        if (_isPressed || widget.isSelected) {
          return context.colors.primary;
        } else {
          return context.colors.onSurfaceVariant;
        }

      case NavbarActionItemStyle.nuetral:
        if (_isPressed || widget.isSelected) {
          return context.colors.onSurface;
        } else {
          return context.colors.onSurfaceVariant;
        }
    }
  }
}

enum NavbarActionItemStyle { nuetral, primary }
