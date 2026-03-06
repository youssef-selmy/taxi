import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum RadioSize {
  small,
  medium;

  double get size {
    return switch (this) {
      RadioSize.small => 20,
      RadioSize.medium => 24,
    };
  }
}

typedef BetterRadio = AppRadio;

class AppRadio<T> extends StatelessWidget {
  final T groupValue;
  final T value;
  final bool isDisabled;
  final void Function(T)? onTap;
  final RadioSize size;

  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onTap,
    this.isDisabled = false,
    this.size = RadioSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: context.colors.primaryContainer,
      hoverColor: context.colors.primaryContainer,
      containedInkWell: true,
      overlayColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: context.colors.primaryContainer,
        WidgetState.focused: context.colors.primaryContainer,
        WidgetState.pressed: context.colors.primaryContainer,
        WidgetState.any: context.colors.transparent,
      }),
      onTap: isDisabled ? null : () => onTap?.call(value),
      radius: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: size.size,
        height: size.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !_isSelected
              ? context.colors.transparent
              : context.colorScheme.primary,
          border: _isSelected
              ? null
              : Border.all(
                  width: 2,
                  color: isDisabled
                      ? context.colors.primaryContainer
                      : context.colors.onSurfaceVariantLow,
                ),
        ),
        child: _isSelected
            ? Center(
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: context.colors.surface,
                ),
              )
            : null,
      ),
    );
  }

  bool get _isSelected => groupValue == value;
}
