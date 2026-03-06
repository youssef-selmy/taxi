import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/scollable_container/scrollable_container.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'filter_item.dart';

class DropDownOverlay<T> extends StatelessWidget {
  final List<FilterItem<T>> items;
  final List<T> selectedItems;
  final void Function(List<T>)? onChanged;

  const DropDownOverlay({
    super.key,
    required this.items,
    required this.selectedItems,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 188,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outline, width: 1),
        boxShadow: context.isDark
            ? null
            : [
                BoxShadow(
                  color: context.colors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          ScrollableContainer(
            maxHeight: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: items.map((item) {
                return Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(color: context.colors.outline),
                      splashRadius: 0,
                      value: selectedItems.contains(item.value),
                      onChanged: (value) {
                        var newSelectedItems = selectedItems.toList();
                        if (value == true) {
                          newSelectedItems = [...newSelectedItems, item.value];
                        } else {
                          newSelectedItems = newSelectedItems
                              .where((element) => element != item.value)
                              .toList();
                        }
                        onChanged?.call(newSelectedItems);
                      },
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.label,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          AppTextButton(
            size: ButtonSize.small,
            text: context.strings.unselectAll,
            onPressed: () {
              onChanged?.call([]);
            },
          ),
        ],
      ),
    );
  }
}
