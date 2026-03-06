import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'button_size.dart';
import 'icon_button_style.dart';
export 'icon_button_style.dart';
export 'button_size.dart';
export 'package:better_design_system/colors/semantic_color.dart';

enum _ButtonState { normal, hover, pressed }

typedef BetterIconButton = AppIconButton;

class AppIconButton extends StatefulWidget {
  final IconButtonStyle style;
  final bool isCircular;
  final bool isSelected;
  final SemanticColor color;
  final IconData icon;
  final IconData? iconSelected;
  final ButtonSize size;
  final bool isDisabled;

  /// Badge options for displaying a dot or counter badge on the button.
  ///
  /// Example:
  /// ```dart
  /// AppIconButton(
  ///   icon: Icons.notifications,
  ///   dotBadge: DotBadgeOptions.counter(count: 5),
  ///   onPressed: () {},
  /// )
  /// ```
  final DotBadgeOptions? dotBadge;

  /// @Deprecated('Use dotBadge instead')
  /// Legacy badge count parameter. Use [dotBadge] for more control.
  final int? badgeCount;

  final VoidCallback? onPressed;
  final Color? iconColor;
  final double? iconSize;

  const AppIconButton({
    super.key,
    required this.icon,
    this.iconSelected,
    this.style = IconButtonStyle.ghost,
    this.isCircular = false,
    this.isSelected = false,
    this.color = SemanticColor.neutral,
    this.size = ButtonSize.large,
    this.isDisabled = false,
    this.onPressed,
    this.dotBadge,
    @Deprecated('Use dotBadge instead') this.badgeCount,
    this.iconColor,
    this.iconSize,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;

  static final Map<Type, Action<Intent>> _actions = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(
      onInvoke: (ActivateIntent intent) {
        return null;
      },
    ),
  };

  static final Map<ShortcutActivator, Intent> _shortcuts =
      <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.enter): const ActivateIntent(),
        const SingleActivator(LogicalKeyboardKey.space): const ActivateIntent(),
      };

  void _handleTap() {
    if (!widget.isDisabled && widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  BorderRadius get _borderRadius {
    if (widget.isCircular) {
      return BorderRadius.circular(100);
    }
    return widget.size.borderRadius;
  }

  _ButtonState get _buttonState {
    if (_isPressed) return _ButtonState.pressed;
    if (_isHovered || _isFocused) return _ButtonState.hover;
    return _ButtonState.normal;
  }

  /// Returns the effective badge options, preferring [dotBadge] over legacy [badgeCount].
  DotBadgeOptions? get _effectiveBadgeOptions {
    if (widget.dotBadge != null) return widget.dotBadge;
    if (widget.badgeCount != null && widget.badgeCount! > 0) {
      return DotBadgeOptions.counter(
        count: widget.badgeCount!,
        color: SemanticColor.error,
        size: DotBadgeSize.small,
      );
    }
    return null;
  }

  Color _getBackgroundColor(BuildContext context) {
    final colors = context.colors;

    if (widget.isDisabled) {
      if (widget.isSelected) {
        return widget.style == IconButtonStyle.outline
            ? widget.color.disabled(context)
            : context.colors.transparent;
      } else {
        return widget.style == IconButtonStyle.ghost
            ? context.colors.transparent
            : colors.surface;
      }
    }

    if (widget.isSelected) {
      return switch (widget.style) {
        IconButtonStyle.outline => switch (_buttonState) {
          _ButtonState.pressed => widget.color.bold(context),
          _ButtonState.hover => widget.color.main(context),
          _ButtonState.normal => widget.color.main(context),
        },
        IconButtonStyle.ghost => switch (_buttonState) {
          _ButtonState.pressed => widget.color.variant(context),
          _ButtonState.hover => widget.color.containerColor(context),
          _ButtonState.normal => context.colors.transparent,
        },
      };
    }

    return switch (widget.style) {
      IconButtonStyle.outline => switch (_buttonState) {
        _ButtonState.pressed => colors.transparent,
        _ButtonState.hover => colors.surfaceVariantLow,
        _ButtonState.normal => colors.surface,
      },
      IconButtonStyle.ghost => switch (_buttonState) {
        _ButtonState.pressed => colors.transparent,
        _ButtonState.hover => colors.surfaceVariantLow,
        _ButtonState.normal => context.colors.transparent,
      },
    };
  }

  Color _getForegroundColor(BuildContext context) {
    final colors = context.colors;

    if (widget.isDisabled) {
      if (widget.isSelected) {
        return widget.color.disabled(context);
      }
      return colors.onSurfaceDisabled;
    }

    if (widget.isSelected) {
      if (widget.style == IconButtonStyle.ghost) {
        return widget.color.main(context);
      } else {
        if (_buttonState == _ButtonState.pressed) {
          return widget.color.bold(context);
        }
        return widget.color.onColor(context);
      }
    }

    if (widget.iconColor != null) {
      return widget.iconColor!;
    }

    return _isHovered ? colors.onSurface : colors.onSurfaceVariant;
  }

  BorderSide _getBorderSide(BuildContext context) {
    final colors = context.colors;

    if (widget.style == IconButtonStyle.ghost) {
      return BorderSide.none;
    }

    if (widget.isDisabled) {
      return widget.isSelected
          ? BorderSide.none
          : BorderSide(color: colors.outlineDisabled, width: 1);
    }

    if (widget.isSelected) {
      final state = _buttonState;
      return switch (state) {
        _ButtonState.hover => BorderSide(
          color: widget.color.variantLow(context),
          width: 1.5,
        ),
        _ButtonState.normal || _ButtonState.pressed => BorderSide.none,
      };
    }

    final state = _buttonState;
    if (widget.style == IconButtonStyle.outline) {
      return switch (state) {
        _ButtonState.normal => BorderSide(color: colors.outline, width: 1),
        _ButtonState.hover => BorderSide(color: colors.outline, width: 1),
        _ButtonState.pressed => BorderSide(
          color: colors.outlineVariant,
          width: 1,
        ),
      };
    }

    return BorderSide.none;
  }

  @override
  Widget build(BuildContext context) {
    final currentBackgroundColor = _getBackgroundColor(context);
    final currentForegroundColor = _getForegroundColor(context);
    final currentBorderSide = _getBorderSide(context);
    final currentBorderRadius = _borderRadius;
    final badgeOptions = _effectiveBadgeOptions;

    final iconData = widget.isSelected && widget.iconSelected != null
        ? widget.iconSelected!
        : widget.icon;

    Widget iconGlyph = Icon(
      iconData,
      size: widget.iconSize ?? widget.size.iconSize,
      color: currentForegroundColor,
    );

    Widget buttonContainer = Container(
      padding: widget.size.padding,
      decoration: BoxDecoration(
        color: currentBackgroundColor,
        borderRadius: currentBorderRadius,
        border: Border.fromBorderSide(currentBorderSide),
      ),
      child: iconGlyph,
    );

    // Wrap with badge if options provided
    Widget content = badgeOptions != null
        ? BetterDotBadgeWrapper(options: badgeOptions, child: buttonContainer)
        : buttonContainer;

    return FocusableActionDetector(
      enabled: !widget.isDisabled,
      focusNode: FocusNode(),
      autofocus: false,
      actions: _actions,
      shortcuts: _shortcuts,
      onShowFocusHighlight: (v) => setState(() => _isFocused = v),
      onShowHoverHighlight: (v) => setState(() => _isHovered = v),
      child: MouseRegion(
        cursor: widget.isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: widget.isDisabled
              ? null
              : (_) => setState(() => _isPressed = true),
          onTapUp: widget.isDisabled
              ? null
              : (_) {
                  setState(() => _isPressed = false);
                },
          onTapCancel: widget.isDisabled
              ? null
              : () => setState(() => _isPressed = false),
          onTap: widget.isDisabled ? null : _handleTap,
          child: content,
        ),
      ),
    );
  }
}
