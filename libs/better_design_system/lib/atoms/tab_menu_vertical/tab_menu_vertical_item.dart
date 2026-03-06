import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_option.dart';
import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

typedef BetterTabMenuVerticalItem = AppTabMenuVerticalItem;

class AppTabMenuVerticalItem<T> extends StatefulWidget {
  const AppTabMenuVerticalItem({
    super.key,
    required this.item,
    required this.selectedValue,
    this.style = TabMenuVerticalStyle.nuetral,
    required this.onPressed,
  });
  final TabMenuVerticalOption item;
  final T selectedValue;
  final TabMenuVerticalStyle style;
  final void Function(T value) onPressed;
  @override
  State<AppTabMenuVerticalItem<T>> createState() =>
      _AppTabMenuVerticalItemState<T>();
}

class _AppTabMenuVerticalItemState<T> extends State<AppTabMenuVerticalItem<T>> {
  bool get isSelected => widget.selectedValue == widget.item.value;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed.call(widget.item.value);
      },
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBackgroundColor(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(widget.item.icon, color: _getTextColor(context), size: 20),

                const SizedBox(width: 8),

                Text(
                  widget.item.title,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: _getTextColor(context),
                  ),
                ),
              ],
            ),

            Row(
              spacing: 8,
              children: [
                if (widget.item.badgeNumber != null) ...[
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colors.onSurface,
                    ),
                    child: Text(
                      widget.item.badgeNumber.toString(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colors.surface,
                      ),
                    ),
                  ),
                ],
                Icon(
                  BetterIcons.arrowRight01Outline,
                  color: _getTextColor(context),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (widget.style) {
      case TabMenuVerticalStyle.nuetral:
        if (_isPressed || isSelected) {
          return context.colors.primaryContainer;
        }
        if (_isHovered) {
          return context.colors.surfaceVariant;
        } else {
          return null;
        }
      case TabMenuVerticalStyle.primary:
        if (_isPressed || isSelected) {
          return context.colors.primaryContainer;
        }
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else {
          return null;
        }
      case TabMenuVerticalStyle.fill:
        if (_isPressed || isSelected) {
          return context.colors.primary;
        }
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else {
          return null;
        }
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (widget.style) {
      case TabMenuVerticalStyle.nuetral:
        if (_isPressed || isSelected) {
          return context.colors.onSurface;
        } else {
          return context.colors.onSurfaceVariant;
        }
      case TabMenuVerticalStyle.primary:
        if (_isPressed || isSelected) {
          return context.colors.primary;
        } else {
          return context.colors.onSurfaceVariant;
        }
      case TabMenuVerticalStyle.fill:
        if (_isPressed || isSelected) {
          return context.colors.onPrimary;
        } else {
          return context.colors.onSurfaceVariant;
        }
    }
  }
}
