import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_item_widget.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../popup_menu_button/popup_menu_item.dart';

export '../popup_menu_button/popup_menu_item.dart';

typedef BetterPopupMenuOverlay = AppPopupMenuOverlay;

class AppPopupMenuOverlay extends StatelessWidget {
  final List<AppPopupMenuItem> items;
  final Function() onItemSelected;
  final bool showArrow;
  final double width;

  const AppPopupMenuOverlay({
    super.key,
    this.width = 160,
    required this.items,
    required this.onItemSelected,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.outline),
        boxShadow: context.isDark
            ? []
            : [
                BoxShadow(
                  color: context.colors.shadow,
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((entry) {
          final item = entry;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.hasDivider) const AppDivider(height: 12),
              AppDropdownItemWidget(
                isSelected: false,
                isMultiSelect: false,
                item: AppDropdownItem(
                  title: item.title,
                  value: 0,
                  prefixIcon: item.icon,
                  prefix: item.prefix,
                  showArrow: showArrow,
                  color: item.color ?? SemanticColor.neutral,
                ),
                onTap: () {
                  onItemSelected.call();
                  item.onPressed.call();
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
