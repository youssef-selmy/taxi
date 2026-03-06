import 'package:better_design_system/atoms/buttons/button_interaction_state.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum LargeActionButtonSize { medium, large }

typedef BetterLargeActionButton = AppLargeActionButton;

class AppLargeActionButton extends StatefulWidget {
  final String title;
  final Function()? onPressed;
  final String imagePath;
  final String? imagePackage;
  final bool isDisabled;
  final LargeActionButtonSize size;

  const AppLargeActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.imagePath,
    this.imagePackage,
    this.isDisabled = false,
    this.size = LargeActionButtonSize.large,
  });

  @override
  State<AppLargeActionButton> createState() => _AppLargeActionButtonState();
}

class _AppLargeActionButtonState extends State<AppLargeActionButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isDisabled
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isDisabled ? null : widget.onPressed,
        onTapUp: (details) => setState(() => _isPressed = false),
        onTapDown: (details) => setState(() => _isPressed = true),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(
            widget.size == LargeActionButtonSize.medium ? 16 : 24,
          ),
          decoration: BoxDecoration(
            border: _border,
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Text(widget.title, style: context.textTheme.titleMedium),
              const Spacer(),
              Image.asset(
                widget.imagePath,
                package: widget.imagePackage,
                width: widget.size == LargeActionButtonSize.medium ? 40 : 80,
                height: widget.size == LargeActionButtonSize.medium ? 40 : 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ButtonInteractionState get interactionState {
    if (widget.isDisabled) {
      return ButtonInteractionState.disabled;
    }
    if (_isPressed) {
      return ButtonInteractionState.pressed;
    }
    if (_isHovered) {
      return ButtonInteractionState.hovered;
    }
    return ButtonInteractionState.normal;
  }

  Border get _border => switch (interactionState) {
    ButtonInteractionState.pressed => Border.all(
      color: context.colors.outlineVariant,
    ),
    ButtonInteractionState.hovered => Border.all(color: context.colors.outline),
    ButtonInteractionState.normal => Border.all(color: _backgroundColor),
    ButtonInteractionState.disabled => Border.all(color: _backgroundColor),
  };

  Color get _backgroundColor => switch (interactionState) {
    ButtonInteractionState.pressed => context.colors.surfaceVariantLow,
    ButtonInteractionState.hovered => context.colors.surfaceVariant,
    ButtonInteractionState.normal => context.colors.surfaceVariant,
    ButtonInteractionState.disabled => context.colors.surfaceMuted,
  };
}
