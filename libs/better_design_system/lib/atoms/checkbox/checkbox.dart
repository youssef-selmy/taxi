import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum CheckboxSize {
  small,
  medium;

  double get size {
    return switch (this) {
      CheckboxSize.small => 20,
      CheckboxSize.medium => 24,
    };
  }
}

typedef BetterCheckbox = AppCheckbox;

class AppCheckbox extends StatelessWidget {
  final bool? value;
  final void Function(bool)? onChanged;
  final CheckboxSize size;
  final bool isDisabled;

  const AppCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.isDisabled = false,
    this.size = CheckboxSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashColor: context.colors.primaryContainer,
      hoverColor: context.colors.primaryContainer,
      containedInkWell: false,
      overlayColor: WidgetStateProperty.fromMap({
        WidgetState.hovered: context.colors.primaryContainer,
        WidgetState.focused: context.colors.primaryContainer,
        WidgetState.pressed: context.colors.primaryContainer,
        WidgetState.any: context.colors.surface,
      }),
      onTap: isDisabled ? null : () => onChanged?.call(!(value ?? false)),
      radius: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: size.size,
        height: size.size,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
          color: _backgroundColor(context),
          border: (value ?? false)
              ? null
              : Border.all(
                  width: 1.5,
                  color: isDisabled
                      ? context.colors.primaryContainer
                      : context.colors.onSurfaceVariantLow,
                ),
        ),
        child: (value ?? false)
            ? Center(
                child: Icon(
                  Icons.check,
                  size: size == CheckboxSize.small ? 12 : 16,
                  color: context.colors.surface,
                ),
              )
            : null,
      ),
    );
  }

  Color _backgroundColor(BuildContext context) {
    if (isDisabled) {
      return context.colors.onSurfaceVariantLow;
    }
    return !(value ?? false)
        ? context.colorScheme.surface
        : context.colorScheme.primary;
  }
}
