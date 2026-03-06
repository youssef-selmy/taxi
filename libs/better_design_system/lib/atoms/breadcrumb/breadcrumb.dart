import 'package:flutter/material.dart';

import 'package:better_icons/better_icons.dart';

import 'package:better_design_system/utils/extensions/extensions.dart';

import 'breadcrumb_option.dart';
import 'breadcrumb_separator.dart';
import 'breadcrumb_style.dart';

export 'breadcrumb_style.dart';
export 'breadcrumb_option.dart';
export 'breadcrumb_separator.dart';

typedef BetterBreadcrumb = AppBreadcrumb;

class AppBreadcrumb<T> extends StatelessWidget {
  const AppBreadcrumb({
    super.key,
    this.style = BreadcrumbStyle.ghost,
    required this.items,
    required this.onPressed,
    this.separator = BreadcrumbSeparator.slash,
  });

  final BreadcrumbStyle style;
  final List<BreadcrumbOption<T>> items;
  final void Function(T value) onPressed;

  final BreadcrumbSeparator separator;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ...items.asMap().entries.expand((entry) {
          final int index = entry.key;
          final BreadcrumbOption<T> item = entry.value;
          final bool isSecondToLast = index == items.length - 2;

          return [
            _BreadcrumbItem(
              item: item,
              selectedValue: items.lastOrNull!.value,
              onPressed: onPressed,
              style: style,
            ),
            if (index < items.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _getSeparator(context, isSecondToLast),
              ),
          ];
        }),
      ],
    );
  }

  Widget _getSeparator(BuildContext context, isSecondToLast) {
    if (separator == BreadcrumbSeparator.slash) {
      return Text(
        '/',
        style: context.textTheme.labelMedium?.copyWith(
          color: isSecondToLast
              ? context.colors.onSurfaceVariant
              : context.colors.onSurfaceVariantLow,
        ),
      );
    } else {
      return Icon(
        BetterIcons.arrowRight01Outline,
        color: isSecondToLast
            ? context.colors.onSurfaceVariant
            : context.colors.onSurfaceVariantLow,
        size: 16,
      );
    }
  }
}

class _BreadcrumbItem<T> extends StatefulWidget {
  const _BreadcrumbItem({
    required this.item,
    required this.selectedValue,
    required this.onPressed,
    required this.style,
  });

  final BreadcrumbOption<T> item;
  final T selectedValue;
  final void Function(T value) onPressed;

  final BreadcrumbStyle style;

  @override
  State<_BreadcrumbItem> createState() => _BreadcrumbItemState<T>();
}

class _BreadcrumbItemState<T> extends State<_BreadcrumbItem<T>> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      onTap: () {
        widget.onPressed(widget.item.value);
      },
      overlayColor: widget.style == BreadcrumbStyle.ghost
          ? WidgetStatePropertyAll(context.colors.transparent)
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: _getBackgroundColor(context),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Row(
          children: [
            if (widget.item.icon != null) ...[
              Icon(
                widget.item.icon!,
                size: 16,
                color: _getForegroundColor(context),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.item.title,
              style: context.textTheme.labelMedium?.copyWith(
                color: _getForegroundColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _isSelected => widget.selectedValue == widget.item.value;

  Color _getForegroundColor(BuildContext context) {
    if (_isHovered) {
      return context.colors.onSurfaceVariant;
    }
    if (_isSelected) {
      return context.colors.onSurface;
    } else {
      return context.colors.onSurfaceVariantLow;
    }
  }

  Color? _getBackgroundColor(BuildContext context) {
    switch (widget.style) {
      case BreadcrumbStyle.ghost:
        return null;
      case BreadcrumbStyle.soft:
        if (_isHovered) {
          return context.colors.surfaceVariantLow;
        } else if (_isSelected) {
          return context.colors.surfaceVariant;
        } else {
          return null;
        }
    }
  }
}
