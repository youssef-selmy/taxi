import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/theme/shadows.dart';

enum ClickableCardType { outline, filled, elevated }

enum _CardInteractionState { normal, pressed, hovered, dragging, disabled }

typedef BetterClickableCard = AppClickableCard;

class AppClickableCard extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;
  final ClickableCardType type;
  final EdgeInsets padding;
  final bool isDisabled;
  final BetterShadow elevation;
  final bool borderLess;

  const AppClickableCard({
    super.key,
    this.onTap,
    required this.child,
    this.type = ClickableCardType.outline,
    this.padding = const EdgeInsets.all(8),
    this.isDisabled = false,
    this.elevation = BetterShadow.shadow8,
    this.borderLess = false,
  });

  @override
  State<AppClickableCard> createState() => _AppClickableCardState();
}

class _AppClickableCardState extends State<AppClickableCard> {
  bool _isPressed = false;
  bool _isHovered = false;
  bool _isDragging = false;

  _CardInteractionState get _interactionState {
    if (widget.isDisabled) {
      return _CardInteractionState.disabled;
    }
    if (widget.onTap == null) {
      return _CardInteractionState.normal;
    }
    if (_isPressed) {
      return _CardInteractionState.pressed;
    } else if (_isHovered) {
      return _CardInteractionState.hovered;
    } else if (_isDragging) {
      return _CardInteractionState.dragging;
    }
    return _CardInteractionState.normal;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) => setState(() => _isDragging = true),
      onPanEnd: (_) => setState(() => _isDragging = false),
      onPanCancel: () => setState(() => _isDragging = false),
      child: InkWell(
        hoverColor: context.colors.transparent,
        highlightColor: context.colors.transparent,
        overlayColor: WidgetStateProperty.fromMap({
          WidgetState.hovered: context.colors.transparent,
          WidgetState.focused: context.colors.transparent,
          WidgetState.pressed: context.colors.transparent,
          WidgetState.any: context.colors.transparent,
        }),
        focusColor: context.colors.transparent,
        splashColor: context.colors.surfaceVariantLow,

        onHighlightChanged: (value) => setState(() => _isPressed = value),
        onHover: (value) => setState(() => _isHovered = value),
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.padding,
          decoration: widget.borderLess
              ? null
              : BoxDecoration(
                  border: Border.all(color: _borderColor(context), width: 1),
                  boxShadow: _boxShadow(context),
                  color: switch (_interactionState) {
                    _CardInteractionState.hovered => _hoverColor(context),
                    _CardInteractionState.pressed => _highlightColor(context),
                    _CardInteractionState.dragging => _draggingColor(context),
                    _CardInteractionState.disabled => _disabledColor(context),
                    _CardInteractionState.normal => _normalColor(context),
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
          child: widget.child,
        ),
      ),
    );
  }

  List<BoxShadow> _boxShadow(BuildContext context) {
    return switch (widget.type) {
      ClickableCardType.outline => switch (_interactionState) {
        _CardInteractionState.hovered => [kShadow4(context)],
        _CardInteractionState.dragging => [kShadow24(context)],
        _ => [],
      },
      ClickableCardType.filled => switch (_interactionState) {
        _CardInteractionState.hovered => [kShadow4(context)],
        _CardInteractionState.dragging => [kShadow24(context)],
        _ => [],
      },
      ClickableCardType.elevated => switch (_interactionState) {
        _CardInteractionState.hovered => [kShadow8(context)],
        _CardInteractionState.dragging => [kShadow24(context)],
        _CardInteractionState.normal => [widget.elevation.toBoxShadow(context)],
        _ => [],
      },
    };
  }

  Color _hoverColor(BuildContext context) => switch (widget.type) {
    ClickableCardType.outline => context.colors.surface,
    ClickableCardType.filled => context.colors.surfaceVariantLow,
    ClickableCardType.elevated => context.colors.surface,
  };

  Color _highlightColor(BuildContext context) => switch (widget.type) {
    ClickableCardType.outline => context.colors.surfaceMuted,
    ClickableCardType.filled => context.colors.surfaceMuted,
    ClickableCardType.elevated => context.colors.surfaceMuted,
  };

  Color _borderColor(BuildContext context) => switch (widget.type) {
    ClickableCardType.outline => switch (_interactionState) {
      _CardInteractionState.hovered => context.colors.outlineVariant,
      _CardInteractionState.pressed => context.colors.outlineVariant,
      _CardInteractionState.dragging => context.colors.outline,
      _CardInteractionState.disabled => context.colors.outline,
      _CardInteractionState.normal => context.colors.outline,
    },
    ClickableCardType.filled => switch (_interactionState) {
      _CardInteractionState.hovered => context.colors.outline,
      _CardInteractionState.pressed => context.colors.outlineVariant,
      _CardInteractionState.dragging => context.colors.outline,
      _CardInteractionState.disabled => context.colors.outline,
      _CardInteractionState.normal => context.colors.outline,
    },
    ClickableCardType.elevated => switch (_interactionState) {
      _CardInteractionState.hovered => context.colors.outline,
      _CardInteractionState.pressed => context.colors.outlineVariant,
      _CardInteractionState.dragging => context.colors.outline,
      _CardInteractionState.disabled => context.colors.outline,
      _CardInteractionState.normal => context.colors.outline,
    },
  };

  Color _disabledColor(BuildContext context) => switch (widget.type) {
    ClickableCardType.outline => context.colors.surfaceMuted,
    ClickableCardType.filled => context.colors.surfaceMuted,
    ClickableCardType.elevated => context.colors.surfaceMuted,
  };

  Color _normalColor(BuildContext context) => switch (widget.type) {
    ClickableCardType.outline => context.colors.surface,
    ClickableCardType.filled => context.colors.surfaceVariantLow,
    ClickableCardType.elevated => context.colors.surface,
  };

  Color _draggingColor(BuildContext context) => switch (widget.type) {
    ClickableCardType.outline => context.colors.surface,
    ClickableCardType.filled => context.colors.surfaceVariantLow,
    ClickableCardType.elevated => context.colors.surface,
  };
}
