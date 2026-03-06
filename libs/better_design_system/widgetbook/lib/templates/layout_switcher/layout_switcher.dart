import 'package:better_design_system/templates/layout_switcher/layout_switcher.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppLayoutSwitcher)
Widget defaultLayoutSwitcher(BuildContext context) {
  return SizedBox(
    width: 300,
    height: 200,
    child: AppLayoutSwitcher(
      title: 'Layout Switcher',
      listViewBuilder: () => const Center(child: Text('List View')),
      gridViewBuilder: () => const Center(child: Text('Grid View')),
      layoutType: LayoutType.grid,
      onLayoutChanged: (value) {},
    ),
  );
}
