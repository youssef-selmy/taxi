import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/buttons/fab_size.dart';
import 'package:better_design_system/molecules/bottom_navigation/item_button_style.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation_item.dart';

const double _kFabSize = 64.0;
const double _kFabBorderRadius = 14.0;

class BottomNavFab<T> extends StatefulWidget {
  final Widget icon;
  final Widget? activeIcon;
  final int? badgeCount;
  final Widget? badge;
  final bool selected;
  final SemanticColor color;
  final bool isDisabled;
  final VoidCallback? onPressed;
  final FabSize fabSize;
  final BottomNavItemDisplayType type;
  final T? value;

  const BottomNavFab({
    super.key,
    required this.icon,
    this.activeIcon,
    this.badgeCount,
    this.badge,
    this.selected = false,
    this.color = SemanticColor.primary,
    this.isDisabled = false,
    this.onPressed,
    this.fabSize = FabSize.extraLarge,
    this.type = BottomNavItemDisplayType.primaryAction,
    this.value,
  });

  @override
  State<BottomNavFab<T>> createState() => _BottomNavFabState<T>();
}

class _BottomNavFabState<T> extends State<BottomNavFab<T>> {
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
      _handleTapRelease();
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

  bool get _isActive =>
      widget.selected || _itemState == ItemButtonStyle.pressed;

  Color _getBackgroundColor(BuildContext context) {
    if (widget.isDisabled) return widget.color.disabled(context);
    if (widget.selected) return widget.color.main(context);

    if (_isFocused && _itemState != ItemButtonStyle.pressed) {
      return widget.color.bold(context);
    }

    switch (_itemState) {
      case ItemButtonStyle.pressed:
        return widget.color.bold(context);
      case ItemButtonStyle.hovered:
      case ItemButtonStyle.normal:
        return widget.color.main(context);
    }
  }

  Widget _applyBadge(BuildContext context, Widget fabLayout) {
    final hasBadge =
        widget.badge != null ||
        (widget.badgeCount != null && widget.badgeCount! > 0);
    if (_isActive || !hasBadge) {
      return fabLayout;
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        fabLayout,
        Positioned(
          top: 16,
          right: 13,
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
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
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

  @override
  Widget build(BuildContext context) {
    final iconToShow = (_isActive && widget.activeIcon != null)
        ? widget.activeIcon!
        : widget.icon;
    final iconColor = widget.color.onColor(context);

    Widget fabBody = AnimatedScale(
      scale: _itemState == ItemButtonStyle.pressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Container(
        width: _kFabSize,
        height: _kFabSize,
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(_kFabBorderRadius),
          boxShadow: [kShadow4(context)],
        ),
        child: Center(
          child: IconTheme(
            data: IconThemeData(color: iconColor, size: 24.0),
            child: iconToShow,
          ),
        ),
      ),
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
          onTap: widget.isDisabled ? null : _handleTap,
          child: _applyBadge(context, fabBody),
        ),
      ),
    );
  }
}
