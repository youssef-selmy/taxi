import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum AppFabStyle { soft, outline }

enum _AppFabInteractionState { normal, hovered, pressed, disabled }

enum _AppFabType { icon, extended }

typedef BetterFab = AppFab;

class AppFab extends StatefulWidget {
  final AppFabStyle style;
  final ButtonSize size;
  final SemanticColor color;
  final IconData? icon;
  final IconData? prefixIcon;
  final String? text;
  final IconData? suffixIcon;
  final bool isDisabled;
  final VoidCallback? onPressed;

  const AppFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.style = AppFabStyle.soft,
    this.size = ButtonSize.medium,
    this.color = SemanticColor.primary,
    this.prefixIcon,
    this.text,
    this.suffixIcon,
    this.isDisabled = false,
  });

  factory AppFab.extended({
    IconData? prefixIcon,
    IconData? suffixIcon,
    required String text,
    required VoidCallback? onPressed,
    AppFabStyle style = AppFabStyle.soft,
    ButtonSize size = ButtonSize.medium,
    SemanticColor color = SemanticColor.primary,
    bool isDisabled = false,
  }) => AppFab(
    icon: prefixIcon,
    suffixIcon: suffixIcon,
    text: text,
    onPressed: onPressed,
    style: style,
    size: size,
    color: color,
    prefixIcon: prefixIcon,
    isDisabled: isDisabled,
  );

  factory AppFab.icon({
    required IconData icon,
    required VoidCallback? onPressed,
    AppFabStyle style = AppFabStyle.soft,
    ButtonSize size = ButtonSize.medium,
    SemanticColor color = SemanticColor.primary,
    bool isDisabled = false,
  }) => AppFab(
    icon: icon,
    onPressed: onPressed,
    style: style,
    size: size,
    color: color,
    isDisabled: isDisabled,
  );

  @override
  createState() => _AppFabState();
}

class _AppFabState extends State<AppFab> {
  bool _isHovered = false;
  bool _isPressed = false;

  _AppFabInteractionState get _interactionState {
    if (widget.isDisabled || widget.onPressed == null) {
      return _AppFabInteractionState.disabled;
    }
    if (_isPressed) return _AppFabInteractionState.pressed;
    if (_isHovered) return _AppFabInteractionState.hovered;
    return _AppFabInteractionState.normal;
  }

  _AppFabType get _type => switch (widget.text) {
    String() => _AppFabType.extended,
    null => _AppFabType.icon,
  };

  @override
  Widget build(BuildContext context) {
    final currentState = _interactionState;
    final Color backgroundColor = _getBackgroundColor(context, currentState);
    final Color foregroundColor = _getForegroundColor(context, currentState);
    final BorderSide borderSide = _getBorderSide(context, currentState);

    final borderRadius = widget.size.borderRadius;
    final padding = switch (_type) {
      _AppFabType.extended => switch (widget.size) {
        ButtonSize.small => const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        ButtonSize.medium => const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        ButtonSize.large => const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        ButtonSize.extraLarge => const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
      },
      _AppFabType.icon => switch (widget.size) {
        ButtonSize.small => const EdgeInsets.all(2),
        ButtonSize.medium => const EdgeInsets.all(6),
        ButtonSize.large => const EdgeInsets.all(10),
        ButtonSize.extraLarge => const EdgeInsets.all(12),
      },
    };
    final iconSize = widget.size.iconSize;
    final effectiveTextStyle = context.textTheme.labelMedium?.copyWith(
      color: foregroundColor,
    );

    final effectivelyDisabled =
        currentState == _AppFabInteractionState.disabled;

    final cursor = switch (effectivelyDisabled) {
      true => SystemMouseCursors.forbidden,
      false => SystemMouseCursors.click,
    };

    return InkWell(
      mouseCursor: cursor,
      borderRadius: borderRadius,
      onHover: effectivelyDisabled
          ? null
          : (hovering) => setState(() => _isHovered = hovering),
      onHighlightChanged: effectivelyDisabled
          ? null
          : (pressed) => setState(() => _isPressed = pressed),
      onTap: effectivelyDisabled ? null : widget.onPressed,
      splashFactory: NoSplash.splashFactory,
      highlightColor: context.colors.transparent,
      splashColor: context.colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [_boxShadow(context, currentState, widget.style)],
          border: Border.fromBorderSide(borderSide),
          borderRadius: borderRadius,
        ),
        child: _buildContent(
          context,
          foregroundColor,
          iconSize,
          effectiveTextStyle,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Color foregroundColor,
    double iconSize,
    TextStyle? textStyle,
  ) => switch (widget.text) {
    String() => _buildExtendedContent(foregroundColor, textStyle),
    null => Icon(widget.icon, size: iconSize, color: foregroundColor),
  };

  Widget _buildExtendedContent(Color foregroundColor, TextStyle? textStyle) =>
      Row(
        spacing: 6,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.prefixIcon != null)
            Icon(widget.prefixIcon, size: 16, color: foregroundColor),
          if (widget.text != null) Text(widget.text!, style: textStyle),
          if (widget.suffixIcon != null)
            Icon(widget.suffixIcon, size: 16, color: foregroundColor),
        ],
      );

  Color _getBackgroundColor(
    BuildContext context,
    _AppFabInteractionState state,
  ) => switch (widget.style) {
    AppFabStyle.soft => switch (state) {
      _AppFabInteractionState.pressed => switch (widget.color) {
        SemanticColor.neutral => context.colors.surface,
        _ => widget.color.containerColor(context),
      },
      _AppFabInteractionState.hovered => widget.color.onColor(context),
      _AppFabInteractionState.normal => switch (widget.color) {
        SemanticColor.neutral => context.colors.surface,
        _ => widget.color.containerColor(context),
      },
      _AppFabInteractionState.disabled => context.colors.surfaceMuted,
    },

    AppFabStyle.outline => switch (state) {
      _AppFabInteractionState.pressed ||
      _AppFabInteractionState.hovered => context.colors.surfaceVariantLow,
      _AppFabInteractionState.normal => context.colors.surface,
      _AppFabInteractionState.disabled => context.colors.surface,
    },
  };

  Color _getForegroundColor(
    BuildContext context,
    _AppFabInteractionState state,
  ) {
    if (state == _AppFabInteractionState.disabled) {
      return context.colors.onSurfaceDisabled;
    }

    switch (widget.style) {
      case AppFabStyle.soft:
        return widget.color.main(context);

      case AppFabStyle.outline:
        return widget.color == SemanticColor.neutral
            ? context.colors.onSurface
            : widget.color.main(context);
    }
  }

  BorderSide _getBorderSide(
    BuildContext context,
    _AppFabInteractionState state,
  ) {
    final colors = context.colors;
    return switch ((widget.style, state)) {
      (AppFabStyle.soft, _AppFabInteractionState.pressed) => BorderSide(
        color: widget.color.main(context),
        width: 1,
      ),
      (AppFabStyle.soft, _AppFabInteractionState.hovered) => BorderSide(
        color: widget.color.variant(context),
        width: 1,
      ),
      (AppFabStyle.soft, _AppFabInteractionState.disabled) => BorderSide(
        color: _getBackgroundColor(context, state),
        width: 1,
      ),
      (AppFabStyle.soft, _AppFabInteractionState.normal) => BorderSide(
        color: _getBackgroundColor(context, state),
        width: 1,
      ),
      (AppFabStyle.outline, _AppFabInteractionState.pressed) => BorderSide(
        color: widget.color == SemanticColor.neutral
            ? colors.outlineBold
            : widget.color.bold(context),
        width: 1,
      ),
      (AppFabStyle.outline, _AppFabInteractionState.hovered) => BorderSide(
        color: widget.color == SemanticColor.neutral
            ? colors.outline
            : widget.color.variant(context),
        width: 1,
      ),
      (AppFabStyle.outline, _AppFabInteractionState.disabled) => BorderSide(
        color: widget.color == SemanticColor.neutral
            ? colors.outlineDisabled
            : widget.color.disabled(context),
        width: 1,
      ),
      (AppFabStyle.outline, _AppFabInteractionState.normal) => BorderSide(
        color: widget.color == SemanticColor.neutral
            ? colors.outline
            : widget.color.variant(context),
        width: 1,
      ),
    };
  }

  BoxShadow _boxShadow(
    BuildContext context,
    _AppFabInteractionState currentState,
    AppFabStyle style,
  ) => BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 8,
    spreadRadius: 0,
    color: context.colorScheme.shadow,
  );
}
