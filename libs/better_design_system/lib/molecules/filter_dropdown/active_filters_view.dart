import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'filter_item.dart';

class ActiveFiltersView<T> extends StatelessWidget {
  final List<FilterItem<T>> items;

  const ActiveFiltersView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (items.isEmpty) {
      return Text("not selected", style: context.textTheme.labelMedium);
    } else if (items.length == 1) {
      return AppTag(text: items.first.label, color: SemanticColor.primary);
    } else {
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              items.length.toString(),
              style: context.textTheme.labelMedium?.apply(
                color: context.colors.primary,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text("Selected", style: context.textTheme.labelMedium),
        ],
      );
    }
  }
}
