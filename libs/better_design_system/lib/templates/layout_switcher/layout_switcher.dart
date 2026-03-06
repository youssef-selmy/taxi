import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

typedef BetterLayoutSwitcher = AppLayoutSwitcher;

class AppLayoutSwitcher extends StatefulWidget {
  final String title;
  final Widget Function() listViewBuilder;
  final Widget Function() gridViewBuilder;
  final LayoutType layoutType;
  final Function(LayoutType) onLayoutChanged;

  const AppLayoutSwitcher({
    super.key,
    required this.title,
    required this.listViewBuilder,
    required this.gridViewBuilder,
    required this.layoutType,
    required this.onLayoutChanged,
  });

  @override
  State<AppLayoutSwitcher> createState() => _AppLayoutSwitcherState();
}

class _AppLayoutSwitcherState extends State<AppLayoutSwitcher> {
  LayoutType selectedType = LayoutType.grid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(widget.title, style: context.textTheme.titleSmall),
            ),
            AppToggleSwitchButtonGroup(
              options: [
                ToggleSwitchButtonGroupOption(
                  value: LayoutType.grid,
                  icon: BetterIcons.dashboardSquare01Filled,
                ),
                ToggleSwitchButtonGroupOption(
                  value: LayoutType.list,
                  icon: BetterIcons.menu01Filled,
                ),
              ],
              selectedValue: selectedType,
              onChanged: (value) {
                widget.onLayoutChanged(value);
                setState(() => selectedType = value);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: selectedType == LayoutType.grid
              ? widget.gridViewBuilder()
              : widget.listViewBuilder(),
        ),
      ],
    );
  }
}

enum LayoutType { list, grid }
