import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class TabItemBordered<T> extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final T value;
  final T? selectedValue;
  final EdgeInsets padding;
  final void Function(T value)? onSelected;

  const TabItemBordered({
    super.key,
    required this.title,
    this.prefixIcon,
    this.prefixWidget,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
    this.subtitle,
    this.suffixWidget,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (onSelected != null) {
          onSelected!(value);
        }
      },
      minimumSize: Size(0, 0),
      child: AnimatedContainer(
        padding: padding,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primaryContainer
              : context.colors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? context.colors.primary : context.colors.outline,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefixWidget != null) ...[
              prefixWidget!,
              const SizedBox(width: 8),
            ],
            if (prefixIcon != null) ...[
              Icon(
                prefixIcon!,
                color: isSelected
                    ? context.colors.primary
                    : context.colors.surfaceVariantLow,
                size: 20,
              ),
              const SizedBox(width: 8),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: isSelected
                        ? context.colors.primary
                        : context.colors.surfaceVariantLow,
                  ),
                ),
                if (subtitle != null) ...[
                  Text(subtitle!, style: context.textTheme.labelMedium),
                ],
              ],
            ),
            if (suffixWidget != null) ...[const Spacer(), suffixWidget!],
          ],
        ),
      ),
    );
  }

  bool get isSelected => value == selectedValue;
}
