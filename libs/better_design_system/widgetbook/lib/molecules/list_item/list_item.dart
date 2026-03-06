import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppListItem)
Widget defaultListItem(BuildContext context) {
  return SizedBox(
    width: 300,
    child: AppListItem(
      title: context.knobs.title,
      subtitle: context.knobs.subtitle,
      // icon: context.knobs.icon,
      leading: Icon(BetterIcons.add01Filled),
      isCompact: context.knobs.isCompact,
      isDisabled: context.knobs.isDisabled,
      actionPosition: context.knobs.object.dropdown(
        label: 'Action Position',
        options: ActionPosition.values,
        initialOption: ActionPosition.end,
        labelBuilder: (value) {
          switch (value) {
            case ActionPosition.start:
              return 'Start';
            case ActionPosition.end:
              return 'End';
          }
        },
      ),
      onTap: (value) {},
      isSelected: context.knobs.isSelected,
      trailing: Text('22\$'),
    ),
  );
}

@UseCase(name: 'withChild', type: AppListItem)
Widget appListItemWhithChild(BuildContext context) {
  return SizedBox(
    width: 600,
    child: AppListItem(
      isCompact: context.knobs.isCompact,
      isDisabled: context.knobs.isDisabled,
      onTap: (value) {},
      isSelected: context.knobs.isSelected,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text('data'), Text('data'), Text('data')],
      ),
    ),
  );
}
