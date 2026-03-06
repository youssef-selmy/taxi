import 'package:better_design_system/molecules/list_item/vertical_toggle_item.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppVerticalToggleItem)
Widget defaultVerticalToggleItem(BuildContext context) {
  return AppVerticalToggleItem(
    title: context.knobs.title,
    subtitle: context.knobs.subtitle,
    leading: Icon(Icons.add),
    isCompact: context.knobs.isCompact,
    isDisabled: context.knobs.isDisabled,
    onTap: (value) {},
    isSelected: context.knobs.isSelected,
    actionType: context.knobs.listItemActionType,
    trailing: Text('22\$'),
  );
}
