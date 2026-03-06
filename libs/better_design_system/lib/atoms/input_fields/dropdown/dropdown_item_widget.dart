import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'dropdown_item.dart';

typedef BetterDropdownItemWidget = AppDropdownItemWidget;

class AppDropdownItemWidget<T> extends StatefulWidget {
  final AppDropdownItem<T> item;
  final bool isSelected;
  final void Function()? onTap;
  final bool isMultiSelect;

  const AppDropdownItemWidget({
    super.key,
    required this.item,
    this.onTap,
    required this.isSelected,
    required this.isMultiSelect,
  });

  @override
  createState() => _AppDropdownItemWidgetState<T>();
}

class _AppDropdownItemWidgetState<T> extends State<AppDropdownItemWidget<T>> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.item.isDisabled ? null : () => widget.onTap?.call(),
      onHover: widget.item.isDisabled
          ? null
          : (value) => setState(() => isHovered = value),
      onHighlightChanged: widget.item.isDisabled
          ? null
          : (value) => setState(() => isPressed = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          borderRadius: BorderRadius.circular(
            widget.item.subtitle != null ? 6 : 4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.item.showCheckbox) ...[
              AppCheckbox(value: widget.isSelected, size: CheckboxSize.small),
              const SizedBox(width: 8),
            ],
            if (widget.item.showRadio) ...[
              AppRadio(
                value: !widget.isSelected,
                size: RadioSize.small,
                groupValue: false,
              ),
              const SizedBox(width: 8),
            ],
            if (widget.item.prefix != null) ...[
              widget.item.prefix!,
              const SizedBox(width: 8),
            ],
            if (widget.item.prefixIcon != null) ...[
              Icon(
                widget.item.prefixIcon,
                size: 20,
                color: _iconColor(context),
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.item.title,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: _textColor(context),
                        ),
                      ),
                      if (widget.item.sublabel != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          '(${widget.item.sublabel})',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (widget.item.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.item.subtitle!,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: widget.item.isDisabled
                            ? context.colors.onSurfaceDisabled
                            : context.colors.onSurfaceVariantLow,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (widget.item.suffix.isNotEmpty) ...[
              ...widget.item.suffix
                  .map((e) => e)
                  .toList()
                  .separated(separator: const SizedBox(width: 8)),
              const SizedBox(width: 10),
            ],
            if (widget.item.showArrow)
              Icon(
                BetterIcons.arrowRight01Outline,
                color: switch (widget.item.color) {
                  SemanticColor.neutral => context.colors.onSurface,
                  _ => widget.item.color.main(context),
                },
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Color? _backgroundColor(BuildContext context) {
    if (isHovered) {
      return context.colors.surfaceVariant;
    } else {
      return null;
    }
  }

  Color _textColor(BuildContext context) {
    if (widget.item.isDisabled) {
      return context.colors.onSurfaceDisabled;
    } else if ((widget.isSelected && isHovered) || isPressed) {
      return switch (widget.item.color) {
        SemanticColor.neutral => context.colors.primary,
        _ => widget.item.color.bold(context),
      };
    } else if (widget.isSelected) {
      return switch (widget.item.color) {
        SemanticColor.neutral => context.colors.primary,
        _ => widget.item.color.bold(context),
      };
    } else {
      return switch (widget.item.color) {
        SemanticColor.neutral => context.colors.onSurface,
        _ => widget.item.color.main(context),
      };
    }
  }

  Color _iconColor(BuildContext context) {
    if (widget.item.isDisabled) {
      return context.colors.onSurfaceDisabled;
    } else if ((widget.isSelected && isHovered) || isPressed) {
      return switch (widget.item.color) {
        SemanticColor.neutral => context.colors.primary,
        _ => widget.item.color.bold(context),
      };
    } else if (widget.isSelected) {
      return context.colors.onSurface;
    } else {
      return switch (widget.item.color) {
        SemanticColor.neutral => context.colors.onSurfaceVariant,
        _ => widget.item.color.main(context),
      };
    }
  }
}
