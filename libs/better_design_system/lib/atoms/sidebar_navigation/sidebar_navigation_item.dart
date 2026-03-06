import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_sub_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

typedef BetterSidebarNavigationItem = AppSidebarNavigationItem;

class AppSidebarNavigationItem<T> extends StatefulWidget {
  final NavigationItem<T> item;
  final T selectedItem;
  final Function(T) onItemSelected;
  final Function(T, bool)? onItemExpansionChanged;
  final double? collapsedWidth;
  final bool isCollapsed;
  final bool isItemExpanded;
  final SidebarNavigationItemStyle style;

  final double? expandedWidth;

  const AppSidebarNavigationItem({
    super.key,
    required this.item,
    required this.selectedItem,
    this.isItemExpanded = false,
    this.isCollapsed = false,
    this.expandedWidth,
    this.collapsedWidth,
    this.style = SidebarNavigationItemStyle.nuetral,
    required this.onItemSelected,
    this.onItemExpansionChanged,
  });
  @override
  State<AppSidebarNavigationItem<T>> createState() =>
      _AppSidebarNavigationItemState<T>();
}

class _AppSidebarNavigationItemState<T>
    extends State<AppSidebarNavigationItem<T>> {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isSelected {
    return widget.item.value == widget.selectedItem || _isPressed;
  }

  bool get _isExpanded {
    return widget.isItemExpanded;
  }

  SidebarItemState get _state {
    if (_isSelected) return SidebarItemState.selected;
    if (_isPressed) return SidebarItemState.pressed;

    if (_isExpanded) return SidebarItemState.expanded;
    if (_isHovered) return SidebarItemState.hovered;

    return SidebarItemState.none;
  }

  @override
  void didUpdateWidget(covariant AppSidebarNavigationItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCollapsed == true &&
        widget.isItemExpanded == true &&
        oldWidget.isCollapsed == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.show();
      });
    }
  }

  final controller = OverlayPortalController();
  final LayerLink _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.hide();
            widget.onItemExpansionChanged?.call(widget.item.value, false);
          },
          child: CompositedTransformFollower(
            offset: const Offset(14, 0),
            targetAnchor: Alignment.topRight,
            followerAnchor: Alignment.topLeft,
            link: _link,
            child: Animate(
              effects: [
                const FadeEffect(
                  duration: Duration(milliseconds: 150),
                  curve: Curves.easeInOut,
                ),
              ],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.collapsedWidth! + 100,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: context.colors.outline),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ...widget.item.subItems
                            .map(
                              (subitem) => AppSidebarNavigationSubItem(
                                selectedSubItem: widget.selectedItem,
                                onPressed: () {
                                  widget.onItemSelected(subitem.value);
                                  controller.hide();
                                  widget.onItemExpansionChanged?.call(
                                    widget.item.value,
                                    false,
                                  );
                                },

                                item: NavigationSubItem(
                                  title: subitem.title,
                                  value: subitem.value,
                                  badgeNumber: subitem.badgeNumber,
                                  badgeTitle: subitem.badgeTitle,
                                  hasDot: subitem.hasDot,
                                ),
                                style: widget.style,
                              ),
                            )
                            .toList()
                            .separated(separator: const SizedBox(height: 8)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

      child: CompositedTransformTarget(
        link: _link,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.expandedWidth != null
                    ? _getItem(context)
                    : Expanded(child: _getItem(context)),
              ],
            ),
            if (_isExpanded &&
                !widget.isCollapsed &&
                widget.item.subItems.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: widget.expandedWidth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 46.0 * widget.item.subItems.length,
                            width: 1,
                            color: context.colors.outline,
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            ...widget.item.subItems
                                .map(
                                  (subitem) => AppSidebarNavigationSubItem(
                                    onPressed: () {
                                      widget.onItemSelected(subitem.value);
                                    },
                                    item: subitem,
                                    style: widget.style,
                                  ),
                                )
                                .toList()
                                .separated(
                                  separator: const SizedBox(height: 8),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  InkWell _getItem(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        if (widget.item.subItems.isNotEmpty) {
          widget.onItemExpansionChanged?.call(
            widget.item.value,
            !widget.isItemExpanded,
          );
        } else {
          widget.onItemSelected(widget.item.value);
        }
        if (widget.item.subItems.isNotEmpty && widget.isCollapsed) {
          if (widget.isItemExpanded) {
            controller.hide();
          } else {
            controller.show();
          }
        }
      },
      onHover: (value) => setState(() => _isHovered = value),
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.isCollapsed
            ? widget.collapsedWidth
            : widget.expandedWidth,
        padding: widget.isCollapsed
            ? const EdgeInsets.only(top: 10, bottom: 10, left: 24)
            : const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _getBackgroundColor(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: widget.isCollapsed
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: [
                    if (widget.item.icon != null) ...[
                      Padding(
                        padding: EdgeInsets.only(
                          right:
                              widget.isCollapsed && widget.item.subItems.isEmpty
                              ? 24
                              : 0,
                        ),
                        child: _getIcon(context),
                      ),

                      SizedBox(
                        width:
                            widget.isCollapsed && widget.item.subItems.isEmpty
                            ? 0
                            : widget.isCollapsed
                            ? 8.5
                            : 8,
                      ),
                    ],
                    if (!widget.isCollapsed) _getLabel(context),

                    if (widget.item.hasDot && !widget.isCollapsed) ...[
                      const SizedBox(width: 8),
                      _doteBadge(context),
                    ],
                  ],
                ),
                Row(
                  children: [
                    if (widget.item.badgeTitle != null &&
                        !widget.isCollapsed) ...[
                      const SizedBox(width: 8),
                      AppBadge(
                        text: widget.item.badgeTitle!,
                        color: SemanticColor.warning,
                        style: _isPressed || _isSelected || _isExpanded
                            ? BadgeStyle.fill
                            : BadgeStyle.soft,
                        isRounded: true,
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (widget.item.badgeNumber != null &&
                        !widget.isCollapsed) ...[
                      if (widget.item.badgeTitle == null)
                        const SizedBox(width: 8),
                      _badgeNumber(context),
                    ],
                    if (widget.item.subItems.isNotEmpty) ...[
                      if (!widget.isCollapsed) const SizedBox(width: 8),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                        turns: widget.isCollapsed
                            ? (_isExpanded ? 0.5 : 0)
                            : (_isExpanded ? 0.75 : 0.25),
                        child: Icon(
                          BetterIcons.arrowRight01Outline,
                          size: 20,
                          color: _getForegroundColor(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),

            if (widget.isCollapsed) ...[
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _getLabel(context),
                  SizedBox(width: widget.item.hasDot ? 4 : 24),
                  if (widget.item.hasDot) _doteBadge(context),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Container _badgeNumber(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
    );
  }

  Text _getLabel(BuildContext context) {
    return Text(
      widget.item.title,
      style: context.textTheme.labelLarge?.copyWith(
        color: _getForegroundColor(context),
      ),
    );
  }

  Widget _getIcon(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        Icon(
          _isSelected || _isExpanded
              ? widget.item.icon!.$2
              : widget.item.icon!.$1,
          color: _getForegroundColor(context),
          size: 20,
        ),
        if (widget.item.badgeNumber != null && widget.isCollapsed)
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.surface,
            ),
            child: Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.error,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    final colors = context.colors;

    switch (widget.style) {
      case SidebarNavigationItemStyle.nuetral:
        return switch (_state) {
          SidebarItemState.hovered ||
          SidebarItemState.expanded => colors.surfaceVariantLow,
          SidebarItemState.pressed ||
          SidebarItemState.selected => colors.surfaceVariant,
          SidebarItemState.none => null,
        };

      case SidebarNavigationItemStyle.primary:
        return switch (_state) {
          SidebarItemState.hovered ||
          SidebarItemState.expanded => colors.surfaceVariantLow,
          SidebarItemState.pressed ||
          SidebarItemState.selected => colors.primaryContainer,
          SidebarItemState.none => null,
        };

      case SidebarNavigationItemStyle.fill:
        return switch (_state) {
          SidebarItemState.hovered ||
          SidebarItemState.expanded => colors.surfaceVariantLow,
          SidebarItemState.pressed ||
          SidebarItemState.selected => colors.primary,
          SidebarItemState.none => null,
        };
    }
  }

  Color _getForegroundColor(BuildContext context) {
    switch (widget.style) {
      case SidebarNavigationItemStyle.nuetral:
        return switch (_state) {
          SidebarItemState.none => context.colors.onSurfaceVariantLow,
          _ => context.colors.onSurface,
        };

      case SidebarNavigationItemStyle.primary:
        return switch (_state) {
          SidebarItemState.none => context.colors.onSurfaceVariantLow,
          _ => context.colors.primary,
        };

      case SidebarNavigationItemStyle.fill:
        return switch (_state) {
          SidebarItemState.none => context.colors.onSurfaceVariantLow,
          SidebarItemState.hovered ||
          SidebarItemState.expanded => context.colors.primary,
          SidebarItemState.selected ||
          SidebarItemState.pressed => context.colors.onPrimary,
        };
    }
  }

  Widget _doteBadge(BuildContext context) {
    final colorValue = switch (widget.style) {
      SidebarNavigationItemStyle.fill => context.colors.primary,
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

enum SidebarItemState { hovered, pressed, selected, expanded, none }
