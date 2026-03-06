import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../select_user_dropdown/select_user_item.dart';

class OperatorDropDownOverlay<T> extends StatelessWidget {
  final List<SelectUserItem<T>> items;
  final List<T> selectedItems;
  final void Function(List<T>)? onChanged;

  const OperatorDropDownOverlay({
    super.key,
    required this.items,
    required this.selectedItems,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 210,
      height: 260,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ...items.map((item) {
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
                    AppAvatar(imageUrl: item.avatar, size: AvatarSize.xl20px),
                    const SizedBox(width: 6),
                    Text(
                      item.label,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                  ],
                );
              }),
            ],
          ),
          const Spacer(),
          AppTextButton(
            size: ButtonSize.small,
            text: "Unselect all",
            onPressed: () {
              onChanged?.call([]);
            },
          ),
        ],
      ),
    );
  }
}
