import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/sidebar_navigation/enum/sidebar_navigation_item_style.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterSidebarNavigationSubItem = AppSidebarNavigationSubItem;

class AppSidebarNavigationSubItem<T> extends StatefulWidget {
  const AppSidebarNavigationSubItem({
    super.key,
    required this.item,
    this.selectedSubItem,
    this.onPressed,
    this.style = SidebarNavigationItemStyle.fill,
  });

  final SidebarNavigationItemStyle style;
  final NavigationSubItem<T> item;
  final T? selectedSubItem;
  final Function()? onPressed;

  @override
  State<AppSidebarNavigationSubItem<T>> createState() =>
      _AppSidebarNavigationSubItemState<T>();
}

class _AppSidebarNavigationSubItemState<T>
    extends State<AppSidebarNavigationSubItem<T>> {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isSelected {
    return widget.item.value == widget.selectedSubItem;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.colors.transparent,
      highlightColor: context.colors.transparent,
      hoverColor: context.colors.transparent,
      focusColor: context.colors.transparent,
      borderRadius: BorderRadius.circular(8),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _getLabel(context),
            Row(
              children: [
                if (widget.item.hasDot) ...[
                  const SizedBox(width: 8),
                  _doteBadge(context),
                ],
                if (widget.item.badgeTitle != null) ...[
                  const SizedBox(width: 8),
                  AppBadge(
                    text: widget.item.badgeTitle!,
                    color: SemanticColor.warning,
                    style: _isPressed ? BadgeStyle.fill : BadgeStyle.soft,
                    isRounded: true,
                  ),
                  const SizedBox(width: 8),
                ],

                if (widget.item.badgeNumber != null) ...[
                  if (widget.item.badgeTitle == null) const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: context.colors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      widget.item.badgeNumber.toString(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colors.onError,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (widget.style) {
      case SidebarNavigationItemStyle.nuetral:
        if (_isPressed) {
          return context.colors.surfaceVariant;
        }
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        }
        if (_isSelected) {
          return context.colors.surfaceVariant;
        } else {
          return context.colors.surface;
        }

      case SidebarNavigationItemStyle.primary:
        if (_isPressed) {
          return context.colors.onPrimary;
        }
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        }
        if (_isSelected) {
          return context.colors.onPrimary;
        } else {
          return context.colors.surface;
        }

      case SidebarNavigationItemStyle.fill:
        if (_isPressed) {
          return context.colors.primary;
        }
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        }
        if (_isSelected) {
          return context.colors.primary;
        } else {
          return context.colors.surface;
        }
    }
  }

  Color _getForegroundColor(BuildContext context) {
    final colors = context.colors;
    switch (widget.style) {
      case SidebarNavigationItemStyle.nuetral:
        if (_isPressed) {
          return colors.onSurface;
        }
        if (_isHovered) {
          return colors.primary;
        }
        if (_isSelected) {
          return colors.onSurface;
        } else {
          return colors.onSurfaceVariant;
        }

      case SidebarNavigationItemStyle.primary:
        if (_isPressed || _isHovered || _isSelected) {
          return colors.primary;
        } else {
          return context.colorScheme.onSurfaceVariant;
        }

      case SidebarNavigationItemStyle.fill:
        if (_isPressed) {
          return colors.onPrimary;
        }
        if (_isHovered) {
          return colors.primary;
        }
        if (_isSelected) {
          return colors.onPrimary;
        } else {
          return colors.onSurfaceVariant;
        }
    }
  }

  Widget _getLabel(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getForegroundColor(context),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          widget.item.title,
          style: context.textTheme.labelLarge?.copyWith(
            color: _getForegroundColor(context),
          ),
        ),
      ],
    );
  }

  Widget _doteBadge(BuildContext context) {
    final colorValue = switch (widget.style) {
      SidebarNavigationItemStyle.fill =>
        _isPressed ? Colors.white : context.colors.primary,
      SidebarNavigationItemStyle.nuetral => context.colors.primary,
      SidebarNavigationItemStyle.primary => context.colors.primary,
    };
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(shape: BoxShape.circle, color: colorValue),
      ),
    );
  }
}
