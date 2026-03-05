import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/molecules/list_item/list_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class RidePreferenceCheckableItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final double? fee;
  final String? currency;
  final bool isSelected;
  final Function(bool) onChanged;

  const RidePreferenceCheckableItem({
    super.key,
    required this.title,
    required this.icon,
    this.fee,
    this.currency,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppListItem(
      onTap: (value) {
        onChanged(value);
      },
      isCompact: true,
      icon: icon,
      title: title,
      subtitle: fee != null && currency != null
          ? "+${fee!.formatCurrency(currency!)}"
          : null,
      actionType: ListItemActionType.radio,
      isSelected: isSelected,
    );
  }
}
