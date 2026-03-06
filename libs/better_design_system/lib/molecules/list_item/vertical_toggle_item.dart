import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'list_item_action_type.dart';

export 'package:better_design_system/atoms/badge/badge.dart';

export 'list_item_action_type.dart';

typedef BetterVerticalToggleItem = AppVerticalToggleItem;

class AppVerticalToggleItem<T> extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final ListItemActionType actionType;
  final List<AppDropdownItem<T>> items;
  final T? initialSelectedItem;
  final ValueChanged<T?>? onDropdownValueChanged;
  final bool isSelected;
  final Function(bool)? onTap;
  final bool isCompact;
  final bool isDisabled;
  final AppBadge? badge;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final SemanticColor iconColor;
  final SemanticColor color;

  const AppVerticalToggleItem({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.leading,
    this.actionType = ListItemActionType.none,
    this.initialSelectedItem,
    this.items = const [],
    this.onDropdownValueChanged,
    this.onTap,
    this.isCompact = false,
    this.isDisabled = false,
    this.badge,
    this.padding,
    this.borderRadius,
    this.iconColor = SemanticColor.neutral,
    this.color = SemanticColor.primary,
    this.trailing,
    this.isSelected = false,
  });

  @override
  createState() => _AppVerticalToggleItemState();
}

class _AppVerticalToggleItemState extends State<AppVerticalToggleItem> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      mouseCursor: widget.isDisabled || widget.onTap == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      borderRadius:
          widget.borderRadius ??
          (widget.isCompact ? null : BorderRadius.circular(10)),
      hoverColor: context.colors.transparent,
      highlightColor: context.colors.transparent,
      focusColor: context.colors.transparent,
      splashColor: context.colors.transparent,
      onTap: widget.isDisabled
          ? null
          : () {
              widget.onTap?.call(!widget.isSelected);
            },
      enableFeedback:
          !widget.isDisabled && !widget.isCompact && widget.onTap != null,
      splashFactory: NoSplash.splashFactory,
      onHover: (isHovered) {
        setState(() {
          _isHovered = isHovered;
        });
      },
      onHighlightChanged: (isPressed) {
        setState(() {
          _isPressed = isPressed;
        });
      },
      child: AnimatedContainer(
        padding:
            widget.padding ??
            (widget.isCompact
                ? null
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          borderRadius:
              widget.borderRadius ??
              (widget.isCompact ? null : BorderRadius.circular(10)),
          border: _border(context),
        ),
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            if (widget.leading != null)
              Opacity(
                opacity: widget.isDisabled ? 0.6 : 1,
                child: widget.leading!,
              ),
            if (widget.icon != null && widget.isCompact == false)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.isDisabled
                        ? context.colors.outlineDisabled
                        : context.colors.outline,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.isDisabled
                      ? context.colors.onSurfaceDisabled
                      : _iconColor(context),
                  size: 20,
                ),
              ),
            if (widget.icon != null && widget.isCompact)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.outline, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  color: context.colors.surfaceVariantLow,
                ),
                child: Icon(
                  widget.icon,
                  size: 20,
                  color: widget.isDisabled
                      ? context.colors.onSurfaceDisabled
                      : _iconColor(context),
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.title != null)
                      Text(
                        widget.title!,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: widget.isDisabled
                              ? context.colors.onSurfaceDisabled
                              : context.colors.onSurface,
                        ),
                      ),
                    if (widget.badge != null) ...[
                      const SizedBox(width: 8),
                      widget.badge!,
                    ],
                  ],
                ),
                if (widget.subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle!,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: widget.isDisabled
                          ? context.colors.onSurfaceDisabled
                          : context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
            if (widget.trailing != null)
              Opacity(
                opacity: widget.isDisabled ? 0.6 : 1,
                child: widget.trailing!,
              ),
            widget.actionType.widget(
              context: context,
              isSelected: widget.isSelected,
              onTap: widget.onTap,
              isDisabled: widget.isDisabled,
              initialSelectedItem: widget.initialSelectedItem,
              items: widget.items,
              onChanged: (p0) => widget.onDropdownValueChanged?.call(p0),
            ),
          ],
        ),
      ),
    );
  }

  Color _iconColor(BuildContext context) =>
      widget.iconColor == SemanticColor.neutral
      ? context.colors.onSurfaceVariant
      : widget.iconColor.main(context);

  Color _backgroundColor(BuildContext context) {
    if (widget.isCompact || widget.isDisabled || widget.onTap == null) {
      return context.colors.surface;
    } else if (_isHovered) {
      return context.colors.surfaceVariantLow;
    } else {
      return context.colors.surface;
    }
  }

  Border _border(BuildContext context) {
    if (widget.onTap == null) {
      return Border.all(color: context.colors.outline, width: 1);
    }
    if (widget.isDisabled && !widget.isCompact) {
      return Border.all(color: context.colors.outlineDisabled, width: 1);
    }
    if (widget.isCompact) {
      return Border.all(color: _backgroundColor(context), width: 1);
    }
    if (_isPressed || widget.isSelected == true) {
      return Border.all(color: widget.color.main(context), width: 1);
    } else {
      return Border.all(color: context.colors.outline, width: 1);
    }
  }
}
