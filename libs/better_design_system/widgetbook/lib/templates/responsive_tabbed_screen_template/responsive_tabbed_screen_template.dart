import 'package:better_design_system/templates/responsive_tabbed_screen_template/responsive_tabbed_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppResponsiveTabbedScreenTemplate)
Widget defaultResponsiveTabbedScreenTemplate(BuildContext context) {
  return AppResponsiveTabbedScreenTemplate(
    title: context.knobs.string(label: 'Title', initialValue: 'Settings'),
    actions: [
      NavigationTabItem(
        title: 'Tab 1',
        icon: Icons.home,
        value: 'tab1',
        child: const Text("Tab 1"),
      ),
      NavigationTabItem(
        title: 'Tab 2',
        icon: Icons.settings,
        value: 'tab2',
        child: const Text("Tab 2"),
      ),
      NavigationTabItem(
        title: 'Tab 3',
        icon: Icons.person,
        value: 'tab3',
        child: const Text("Tab 3"),
      ),
    ],
  );
}
