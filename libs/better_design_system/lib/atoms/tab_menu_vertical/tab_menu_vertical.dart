import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_item.dart';
import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_option.dart';
import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_style.dart';
import 'package:better_design_system/atoms/tab_menu_vertical/tab_menu_vertical_type.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
export 'tab_menu_vertical_option.dart';
export 'tab_menu_vertical_style.dart';
export 'tab_menu_vertical_type.dart';

typedef BetterTabMenuVertical = AppTabMenuVertical;

class AppTabMenuVertical<T> extends StatefulWidget {
  const AppTabMenuVertical({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.style = TabMenuVerticalStyle.nuetral,
    this.type = TabMenuVerticalType.card,
    this.width = 252,
    this.title,
  });

  final List<TabMenuVerticalOption<T>> items;
  final T selectedValue;
  final TabMenuVerticalStyle style;
  final TabMenuVerticalType type;
  final void Function(T value) onChanged;
  final double width;
  final String? title;

  @override
  State<AppTabMenuVertical<T>> createState() => _AppTabMenuVerticalState<T>();
}

class _AppTabMenuVerticalState<T> extends State<AppTabMenuVertical<T>> {
  bool get _isCard => widget.type == TabMenuVerticalType.card;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: _isCard ? const EdgeInsets.all(10) : EdgeInsets.zero,
      decoration: BoxDecoration(
        border: _isCard
            ? Border.all(width: 1, color: context.colors.outline)
            : null,
        color: _isCard ? context.colors.surface : null,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.title != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Select menu',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colors.onSurfaceVariantLow,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: context.colors.outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          ...widget.items
              .map(
                (item) => AppTabMenuVerticalItem(
                  item: item,
                  selectedValue: widget.selectedValue,
                  style: widget.style,
                  onPressed: widget.onChanged,
                ),
              )
              .toList()
              .separated(separator: const SizedBox(height: 8)),
        ],
      ),
    );
  }
}
