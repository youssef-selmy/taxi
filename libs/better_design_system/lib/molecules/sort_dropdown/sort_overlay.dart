import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/atoms/scollable_container/scrollable_container.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortOverlay<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final void Function(T)? onChanged;
  final String Function(T) labelGetter;
  final double width;

  const SortOverlay({
    super.key,
    required this.items,
    required this.selectedItem,
    this.onChanged,
    required this.labelGetter,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: width,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outline, width: 1),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ScrollableContainer(
            maxHeight: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: items.map((item) {
                return Row(
                  children: [
                    AppRadio<T?>(
                      groupValue: selectedItem,
                      value: item,
                      onTap: (value) {
                        onChanged?.call(value as T);
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        labelGetter(item),
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
