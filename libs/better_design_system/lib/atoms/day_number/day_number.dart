import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterDayNumber = AppDayNumber;

class AppDayNumber extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  final void Function(bool)? onHover;
  final DayNumberType type;
  final bool isSelected;
  final bool isDisabled;
  final bool isActive;
  final BorderRadiusGeometry borderRadius;
  final bool hasDot;

  const AppDayNumber({
    super.key,
    this.type = DayNumberType.single,
    this.isSelected = false,
    this.isDisabled = false,
    this.isActive = false,
    this.hasDot = false,
    required this.title,
    this.onPressed,
    this.onHover,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  State<AppDayNumber> createState() => _AppDayNumberState();
}

class _AppDayNumberState extends State<AppDayNumber> {
  bool _isHovered = false;
  bool _isPressed = false;

  DayNumberState get _state {
    if (widget.isDisabled) return DayNumberState.disabled;
    if (_isPressed) return DayNumberState.pressed;
    if (widget.isActive) return DayNumberState.active;
    if (widget.isSelected) return DayNumberState.selected;
    if (_isHovered) return DayNumberState.hovered;

    return DayNumberState.none;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _state == DayNumberState.disabled ? null : widget.onPressed,
      onHover: (value) {
        setState(() => _isHovered = value);
        if (widget.onHover != null) widget.onHover!(value);
      },
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border:
              _state == DayNumberState.selected ||
                  _state == DayNumberState.pressed
              ? Border.all(width: 1, color: context.colors.primary)
              : null,
          color: _getBackgroundColor(context),
          borderRadius: widget.borderRadius,
        ),
        child: Center(
          child: Column(
            spacing: 3,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: context.textTheme.labelMedium?.copyWith(
                  color: _getFourgroundColor(context),
                ),
              ),
              if (widget.hasDot)
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _state == DayNumberState.disabled
                        ? context.colors.onSurfaceMuted
                        : _state == DayNumberState.active
                        ? context.colors.onPrimary
                        : context.colors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    return switch (_state) {
      DayNumberState.disabled => context.colors.surface,
      DayNumberState.pressed => context.colors.surface,
      DayNumberState.none =>
        widget.type == DayNumberType.range
            ? context.colors.primaryVariantLow
            : context.colors.surface,
      DayNumberState.hovered =>
        widget.type == DayNumberType.single
            ? context.colors.surfaceVariant
            : context.colors.primaryVariant,
      DayNumberState.selected => context.colors.surface,
      DayNumberState.active => context.colors.primary,
    };
  }

  Color _getFourgroundColor(BuildContext context) {
    return switch (_state) {
      DayNumberState.disabled => context.colors.onSurfaceMuted,
      DayNumberState.pressed => context.colors.onSurface,
      DayNumberState.none =>
        widget.type == DayNumberType.range
            ? context.colors.primary
            : context.colors.onSurface,
      DayNumberState.hovered => context.colors.onSurface,
      DayNumberState.selected => context.colors.onSurface,
      DayNumberState.active => context.colors.onPrimary,
    };
  }
}

enum DayNumberType { single, range }

enum DayNumberState { none, hovered, selected, pressed, active, disabled }
