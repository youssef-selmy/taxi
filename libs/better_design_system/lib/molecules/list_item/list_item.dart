import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'list_item_action_type.dart';

export 'package:better_design_system/atoms/badge/badge.dart';

export 'list_item_action_type.dart';

enum ActionPosition { start, end }

typedef BetterListItem = AppListItem;

class AppListItem<T> extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final Widget? child;
  final ListItemActionType actionType;
  final List<AppDropdownItem<T>> items;
  final ValueChanged<T?>? onDropdownValueChanged;
  final T? initialSelectedItem;
  final ActionPosition actionPosition;
  final bool isSelected;
  final Function(bool)? onTap;
  final bool isCompact;
  final bool isDisabled;
  final AppBadge? badge;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final SemanticColor iconColor;
  final Widget? subtitleWidget;

  const AppListItem({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.leading,
    this.subtitleWidget,
    this.actionType = ListItemActionType.none,
    this.items = const [],
    this.onDropdownValueChanged,
    this.initialSelectedItem,
    this.actionPosition = ActionPosition.end,
    this.onTap,
    this.isCompact = false,
    this.isDisabled = false,
    this.badge,
    this.padding,
    this.borderRadius,
    this.iconColor = SemanticColor.neutral,
    this.trailing,
    this.isSelected = false,
    this.child,
  }) : assert(
         subtitle == null || subtitleWidget == null,
         'Only one of subtitle or subtitleWidget can be provided.',
       );

  @override
  createState() => _AppListItemState<T>();
}

class _AppListItemState<T> extends State<AppListItem<T>> {
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
          (widget.isCompact
              ? BorderRadius.circular(8)
              : BorderRadius.circular(10)),
      hoverColor: context.colors.transparent,
      highlightColor: context.colors.transparent,
      focusColor: context.colors.transparent,
      splashColor: context.colors.transparent,
      onTap: widget.isDisabled
          ? null
          : () {
              widget.onTap?.call(!widget.isSelected);
            },
      enableFeedback: !widget.isDisabled && widget.onTap != null,
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
                ? const EdgeInsets.symmetric(horizontal: 4, vertical: 4)
                : const EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          borderRadius:
              widget.borderRadius ??
              (widget.isCompact
                  ? BorderRadius.circular(8)
                  : BorderRadius.circular(10)),
          border: _border(context),
        ),
        duration: const Duration(milliseconds: 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (widget.actionPosition == ActionPosition.start) ...[
                  widget.actionType.widget(
                    context: context,
                    isSelected: widget.isSelected,
                    onTap: widget.onTap,
                    isDisabled: widget.isDisabled,
                    items: widget.items,
                    initialSelectedItem: widget.initialSelectedItem,
                    onChanged: (value) {
                      if (widget.onDropdownValueChanged != null) {
                        widget.onDropdownValueChanged!(value);
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                ],
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
                      border: Border.all(
                        color: context.colors.outline,
                        width: 1,
                      ),
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
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      if (widget.subtitle != null ||
                          widget.subtitleWidget != null) ...[
                        const SizedBox(height: 4),

                        if (widget.subtitle != null)
                          Text(
                            widget.subtitle!,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: widget.isDisabled
                                  ? context.colors.onSurfaceDisabled
                                  : context.colors.onSurfaceVariant,
                            ),
                          ),

                        if (widget.subtitleWidget != null)
                          widget.subtitleWidget!,
                      ],
                    ],
                  ),
                ),
                if (widget.trailing != null)
                  Opacity(
                    opacity: widget.isDisabled ? 0.6 : 1,
                    child: widget.trailing!,
                  ),
                if (widget.actionPosition == ActionPosition.end)
                  widget.actionType.widget<T>(
                    context: context,
                    isSelected: widget.isSelected,
                    onTap: widget.onTap,
                    isDisabled: widget.isDisabled,
                    items: widget.items,
                    initialSelectedItem: widget.initialSelectedItem,
                    onChanged: (value) {
                      if (widget.onDropdownValueChanged != null) {
                        widget.onDropdownValueChanged!(value);
                      }
                    },
                  ),
              ],
            ),
            if (widget.child != null) ...[
              const SizedBox(height: 8),
              Opacity(
                opacity: widget.isDisabled ? 0.6 : 1,
                child: widget.child!,
              ),
            ],
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
    if (widget.isDisabled || widget.onTap == null) {
      return context.colors.surface;
    }
    if (_isHovered || (_isPressed && widget.isCompact)) {
      return context.colors.surfaceVariantLow;
    }
    return context.colors.surface;
  }

  Border _border(BuildContext context) {
    if (widget.isCompact) {
      return Border.all(
        color: _isPressed ? context.colors.outline : _backgroundColor(context),
        width: 1,
      );
    }
    if (widget.onTap == null) {
      return Border.all(color: context.colors.outline, width: 1);
    }
    if (widget.isDisabled && !widget.isCompact) {
      return Border.all(color: context.colors.outlineDisabled, width: 1);
    }
    if (_isPressed || widget.isSelected == true) {
      return Border.all(color: context.colors.primary, width: 1);
    } else {
      return Border.all(color: context.colors.outline, width: 1);
    }
  }
}
