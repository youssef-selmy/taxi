import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'dropdown_item.dart';
import 'dropdown_item_widget.dart';

class DropDownCompactOverlay<T> extends StatelessWidget {
  final List<AppDropdownItem<T>> items;
  final List<T>? selectedValue;
  final void Function(List<T>?)? onChanged;
  final double? width;
  final bool isMultiSelect;

  const DropDownCompactOverlay({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.width,
    required this.isMultiSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(maxHeight: 300),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outline),
        boxShadow: context.isDark
            ? null
            : [
                BoxShadow(
                  color: context.colors.shadow,
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                  spreadRadius: 0,
                ),
              ],
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = items[index];
          return AppDropdownItemWidget(
            item: item,
            isSelected: selectedValue?.contains(item.value) ?? false,
            isMultiSelect: isMultiSelect,
            onTap: () {
              if (selectedValue?.contains(item.value) ?? false) {
                if (isMultiSelect) {
                  onChanged?.call(
                    selectedValue
                        ?.where((element) => element != item.value)
                        .toList(),
                  );
                }
              } else {
                onChanged?.call([...(selectedValue ?? []), item.value]);
              }
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 4),
        itemCount: items.length,
      ),
    );
  }
}
