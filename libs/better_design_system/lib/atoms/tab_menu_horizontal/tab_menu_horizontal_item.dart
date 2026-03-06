import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_option.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

enum TabMenuHorizontalItemState { hovered, pressed, selected, none }

typedef BetterTabMenuHorizontalItem = AppTabMenuHorizontalItem;

class AppTabMenuHorizontalItem<T> extends StatefulWidget {
  const AppTabMenuHorizontalItem({
    super.key,
    required this.item,
    required this.selectedValue,
    this.style = TabMenuHorizontalStyle.nuetral,
    required this.onPressed,
    required this.color,
  });
  final TabMenuHorizontalOption<T> item;
  final T selectedValue;
  final TabMenuHorizontalStyle style;
  final SemanticColor color;
  final void Function(T value)? onPressed;

  @override
  State<AppTabMenuHorizontalItem<T>> createState() =>
      _AppTabMenuHorizontalItemState<T>();
}

class _AppTabMenuHorizontalItemState<T>
    extends State<AppTabMenuHorizontalItem<T>> {
  bool get isSelected => widget.selectedValue == widget.item.value;
  bool _isHovered = false;
  bool _isPressed = false;

  TabMenuHorizontalItemState get _state {
    if (isSelected) return TabMenuHorizontalItemState.selected;
    if (_isPressed) return TabMenuHorizontalItemState.pressed;
    if (_isHovered) return TabMenuHorizontalItemState.hovered;
    return TabMenuHorizontalItemState.none;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: true, // full rect is hoverable even if visually transparent
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onPressed != null
            ? () {
                widget.onPressed!(widget.item.value);
              }
            : null,
        borderRadius: BorderRadius.circular(8),
        onHover: (value) => setState(() => _isHovered = value),
        onHighlightChanged: (value) => setState(() => _isPressed = value),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            color: _getBackgroundColor(context),
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          padding:
              widget.style == TabMenuHorizontalStyle.soft ||
                  widget.style == TabMenuHorizontalStyle.fill
              ? const EdgeInsets.all(10)
              : const EdgeInsets.fromLTRB(12, 10, 12, 10),

          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.item.icon != null)
                Icon(widget.item.icon, size: 20, color: _getTextColor(context)),
              if (widget.item.prefixWidget != null) widget.item.prefixWidget!,
              Text(
                widget.item.title,
                style: context.textTheme.labelLarge?.copyWith(
                  color: _getTextColor(context),
                ),
              ),

              if (widget.item.badgeNumber != null) ...[
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color.main(context),
                  ),
                  child: Text(
                    widget.item.badgeNumber! < 100
                        ? widget.item.badgeNumber.toString()
                        : '99+',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: widget.color.onColor(context),
                    ),
                  ),
                ),
              ],
              if (widget.item.showArrow)
                Icon(
                  BetterIcons.arrowRight01Outline,
                  size: 20,
                  color: _getTextColor(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    switch (widget.style) {
      case TabMenuHorizontalStyle.nuetral:
        return switch (_state) {
          TabMenuHorizontalItemState.pressed ||
          TabMenuHorizontalItemState.hovered ||
          TabMenuHorizontalItemState.selected => context.colors.onSurface,
          TabMenuHorizontalItemState.none => context.colors.onSurfaceVariant,
        };

      case TabMenuHorizontalStyle.primary:
      case TabMenuHorizontalStyle.ghost:
        return switch (_state) {
          TabMenuHorizontalItemState.pressed ||
          TabMenuHorizontalItemState.selected => widget.color.main(context),
          TabMenuHorizontalItemState.hovered => context.colors.onSurface,
          TabMenuHorizontalItemState.none => context.colors.onSurfaceVariant,
        };

      case TabMenuHorizontalStyle.soft:
        return switch (_state) {
          TabMenuHorizontalItemState.pressed ||
          TabMenuHorizontalItemState.selected => widget.color.main(context),
          TabMenuHorizontalItemState.hovered ||
          TabMenuHorizontalItemState.none => context.colors.onSurfaceVariant,
        };
      case TabMenuHorizontalStyle.fill:
        return switch (_state) {
          TabMenuHorizontalItemState.pressed ||
          TabMenuHorizontalItemState.selected => widget.color.onColor(context),
          TabMenuHorizontalItemState.hovered ||
          TabMenuHorizontalItemState.none => context.colors.onSurfaceVariant,
        };
    }
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (widget.style == TabMenuHorizontalStyle.soft) {
      return switch (_state) {
        TabMenuHorizontalItemState.pressed ||
        TabMenuHorizontalItemState.selected => context.colors.surfaceVariant,
        TabMenuHorizontalItemState.hovered => context.colors.surfaceVariantLow,
        TabMenuHorizontalItemState.none => context.colors.surface.withAlpha(0),
      };
    }

    if (widget.style == TabMenuHorizontalStyle.fill) {
      return switch (_state) {
        TabMenuHorizontalItemState.pressed ||
        TabMenuHorizontalItemState.selected => widget.color.main(context),
        TabMenuHorizontalItemState.hovered => context.colors.surfaceVariantLow,
        TabMenuHorizontalItemState.none => context.colors.surface.withAlpha(0),
      };
    } else {
      return context.colors.surface.withAlpha(0);
    }
  }
}
