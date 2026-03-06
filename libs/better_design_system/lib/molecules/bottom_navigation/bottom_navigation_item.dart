import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/molecules/bottom_navigation/item_button_style.dart';

const double _kBottomNavHeight = 88.0;

enum BottomNavItemDisplayType {
  withoutContainerVertical,
  withoutContainerHorizontal,
  withoutContainerNoTitle,
  withContainerVertical,
  withContainerNoTitle,
  primaryAction,
}

typedef BetterBottomNavigationItem = AppBottomNavigationItem;

class AppBottomNavigationItem<T> extends StatefulWidget {
  final Widget icon;
  final Widget? activeIcon;
  final String? label;
  final int? badgeCount;
  final Widget? badge;
  final bool selected;
  final SemanticColor color;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final BottomNavItemDisplayType displayType;
  final T value;

  const AppBottomNavigationItem({
    super.key,
    required this.icon,
    this.activeIcon,
    this.label,
    this.badgeCount,
    this.badge,
    this.selected = false,
    this.color = SemanticColor.primary,
    this.isDisabled = false,
    this.onPressed,
    this.displayType = BottomNavItemDisplayType.withoutContainerHorizontal,
    required this.value,
  });

  @override
  State<AppBottomNavigationItem<T>> createState() =>
      _AppBottomNavigationItemState<T>();
}

class _AppBottomNavigationItemState<T>
    extends State<AppBottomNavigationItem<T>> {
  ItemButtonStyle _itemState = ItemButtonStyle.normal;
  bool _isFocused = false;
  late final FocusNode _focusNode;
  late final Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (_) => _handleTap(),
      ),
    };
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.isDisabled) {
      widget.onPressed?.call();
      _handleTapRelease(); // Reset state after successful tap
    }
  }

  void _handleTapDown() {
    if (!widget.isDisabled && mounted) {
      setState(() {
        _itemState = ItemButtonStyle.pressed;
      });
    }
  }

  void _handleTapRelease() {
    if (mounted) {
      setState(() {
        _itemState = _focusNode.hasFocus
            ? ItemButtonStyle.hovered
            : ItemButtonStyle.normal;
      });
    }
  }

  void _handleHoverEnter() {
    if (!widget.isDisabled &&
        mounted &&
        _itemState != ItemButtonStyle.pressed) {
      setState(() {
        _itemState = ItemButtonStyle.hovered;
      });
    }
  }

  void _handleHoverExit() {
    if (!widget.isDisabled &&
        mounted &&
        _itemState != ItemButtonStyle.pressed) {
      setState(() {
        _itemState = _isFocused
            ? ItemButtonStyle.hovered
            : ItemButtonStyle.normal;
      });
    }
  }

  bool get _isInteractive =>
      _itemState == ItemButtonStyle.hovered ||
      _itemState == ItemButtonStyle.pressed ||
      _isFocused;

  bool get _isActive =>
      widget.selected || _itemState == ItemButtonStyle.pressed;

  Color _getIconColor(BuildContext context) {
    if (widget.isDisabled) return context.colors.onSurfaceDisabled;
    if (_isActive && widget.activeIcon != null) {
      return widget.color.main(context);
    }
    if (widget.selected) return widget.color.main(context);
    if (_isInteractive) return context.colors.onSurface;
    return context.colors.onSurfaceVariant;
  }

  TextStyle? _getLabelStyle(BuildContext context) {
    final isHorizontal =
        widget.displayType ==
        BottomNavItemDisplayType.withoutContainerHorizontal;
    final isWithContainer =
        widget.displayType == BottomNavItemDisplayType.withContainerVertical;

    if (isWithContainer) {
      return widget.selected
          ? context.textTheme.labelMedium?.copyWith(
              color: widget.color.main(context),
              fontWeight: FontWeight.w500,
            )
          : _itemState == ItemButtonStyle.pressed
          ? context.textTheme.bodySmall?.copyWith(
              color: widget.color.main(context),
            )
          : null;
    }

    Color labelColor;
    FontWeight fontWeight;

    if (_isActive) {
      labelColor = widget.isDisabled
          ? context.colors.onSurfaceDisabled
          : widget.color.main(context);
      fontWeight = FontWeight.w500;
    } else {
      labelColor = widget.isDisabled
          ? context.colors.onSurfaceDisabled
          : (_itemState == ItemButtonStyle.hovered
                ? context.colors.onSurfaceVariant
                : context.colors.onSurfaceVariantLow);
      fontWeight = isHorizontal ? FontWeight.w400 : FontWeight.normal;
    }

    final textTheme = _isActive
        ? context.textTheme.labelMedium
        : context.textTheme.bodySmall;

    return textTheme?.copyWith(color: labelColor, fontWeight: fontWeight);
  }

  Color _getContainerBackgroundColor(BuildContext context) {
    if (widget.selected || _itemState == ItemButtonStyle.pressed) {
      return widget.color.containerColor(context);
    }
    if (_itemState == ItemButtonStyle.hovered) {
      return context.colors.surfaceVariantLow;
    }
    return context.colors.transparent;
  }

  Widget _buildIcon(BuildContext context) {
    final iconToShow = (_isActive && widget.activeIcon != null)
        ? widget.activeIcon!
        : widget.icon;

    return IconTheme(
      data: IconThemeData(color: _getIconColor(context), size: 24),
      child: iconToShow,
    );
  }

  Widget? _buildLabel(BuildContext context) {
    final bool canShowLabel =
        widget.label != null &&
        widget.label!.isNotEmpty &&
        widget.displayType !=
            BottomNavItemDisplayType.withoutContainerNoTitle &&
        widget.displayType != BottomNavItemDisplayType.withContainerNoTitle &&
        widget.selected; // Only show label when selected

    if (!canShowLabel) return null;

    return Text(
      widget.label!,
      style: _getLabelStyle(context),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildItemLayout(BuildContext context, Widget icon, Widget? label) {
    switch (widget.displayType) {
      case BottomNavItemDisplayType.withoutContainerHorizontal:
        return AnimatedScale(
          scale: _itemState == ItemButtonStyle.pressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              if (label != null) ...[const SizedBox(height: 8.0), label],
            ],
          ),
        );
      case BottomNavItemDisplayType.withoutContainerNoTitle:
        return AnimatedScale(
          scale: _itemState == ItemButtonStyle.pressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: icon,
        );
      case BottomNavItemDisplayType.withContainerVertical:
        return AnimatedScale(
          scale: _itemState == ItemButtonStyle.pressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _getContainerBackgroundColor(context),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: label != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [icon, const SizedBox(width: 4.0), label],
                  )
                : icon,
          ),
        );
      case BottomNavItemDisplayType.withContainerNoTitle:
        return AnimatedScale(
          scale: _itemState == ItemButtonStyle.pressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _getContainerBackgroundColor(context),
              shape: BoxShape.circle,
            ),
            child: icon,
          ),
        );
      case BottomNavItemDisplayType.withoutContainerVertical:
      case BottomNavItemDisplayType.primaryAction:
        return AnimatedScale(
          scale: _itemState == ItemButtonStyle.pressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 100),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              if (label != null) ...[const SizedBox(width: 8.0), label],
            ],
          ),
        );
    }
  }

  Widget _applyBadge(BuildContext context, Widget itemLayout) {
    final hasBadge =
        widget.badge != null ||
        (widget.badgeCount != null && widget.badgeCount! > 0);
    if (_isActive || !hasBadge) {
      return itemLayout;
    }

    final bool isWithContainer =
        widget.displayType == BottomNavItemDisplayType.withContainerVertical ||
        widget.displayType == BottomNavItemDisplayType.withContainerNoTitle;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        itemLayout,
        Positioned(
          top: isWithContainer ? 4.0 : -4.0,
          right: isWithContainer ? 2.0 : -6.0,
          child:
              widget.badge ??
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.badgeCount! <= 9 ? 5.0 : 4.0,
                  vertical: 1.5,
                ),
                decoration: BoxDecoration(
                  color: SemanticColor.error.main(context),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 16.0,
                  minHeight: 16.0,
                ),
                child: Center(
                  child: Text(
                    widget.badgeCount.toString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: SemanticColor.error.onColor(context),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        ),
      ],
    );
  }

  Widget _applyIndicator(BuildContext context, Widget itemLayout) {
    if (widget.isDisabled) {
      return itemLayout;
    }

    final (width, height) = switch (widget.displayType) {
      BottomNavItemDisplayType.withoutContainerHorizontal => (40.0, 3.5),
      BottomNavItemDisplayType.withoutContainerVertical => (64.0, 3.5),
      BottomNavItemDisplayType.withContainerVertical => (64.0, 3.5),
      BottomNavItemDisplayType.withContainerNoTitle => (40.0, 3.5),
      BottomNavItemDisplayType.withoutContainerNoTitle => (40.0, 3.5),
      _ => (0.0, 0.0),
    };

    Color indicatorColor = context.colors.transparent;
    if (widget.selected) {
      indicatorColor = widget.color.main(context);
    } else if (_itemState == ItemButtonStyle.pressed) {
      indicatorColor = widget.color.containerColor(context);
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        itemLayout,
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: indicatorColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconWidget = _buildIcon(context);
    final labelWidget = _buildLabel(context);

    Widget itemLayout = _buildItemLayout(context, iconWidget, labelWidget);
    itemLayout = _applyBadge(context, itemLayout);

    final Widget finalLayout = _applyIndicator(
      context,
      Center(child: itemLayout),
    );

    return MouseRegion(
      cursor: widget.isDisabled
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => _handleHoverEnter(),
      onExit: (_) => _handleHoverExit(),
      child: FocusableActionDetector(
        enabled: !widget.isDisabled,
        focusNode: _focusNode,
        actions: _actionMap,
        onFocusChange: (isFocused) => setState(() => _isFocused = isFocused),
        child: GestureDetector(
          onTapDown: widget.isDisabled ? null : (_) => _handleTapDown(),
          onTapUp: widget.isDisabled ? null : (_) => _handleTapRelease(),
          onTapCancel: widget.isDisabled ? null : _handleTapRelease,
          onTap: _handleTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: _kBottomNavHeight,
            alignment: Alignment.center,
            color: context.colors.transparent,
            child: finalLayout,
          ),
        ),
      ),
    );
  }
}
