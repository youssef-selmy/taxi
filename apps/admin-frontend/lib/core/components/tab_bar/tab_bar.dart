import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/tab_bar/tab_item.dart';

export 'tab_item.dart';

class AppTabBar extends StatefulWidget {
  final List<AppTabItem> tabs;
  final TabController tabController;
  final bool isCompact;
  final Function(int)? onTabChanged;
  final SemanticColor? color;

  const AppTabBar({
    super.key,
    required this.tabs,
    required this.tabController,
    required this.isCompact,
    this.onTabChanged,
    this.color = SemanticColor.primary,
  });

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tabController.index;
    widget.tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  void _handleTabChange() {
    if (mounted && _currentIndex != widget.tabController.index) {
      setState(() {
        _currentIndex = widget.tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTabMenuHorizontal(
      controller: widget.tabController,
      style: TabMenuHorizontalStyle.soft,
      color: widget.color ?? SemanticColor.primary,
      selectedValue: _currentIndex,
      onChanged: (value) {
        widget.tabController.animateTo(value);
        widget.onTabChanged?.call(value);
      },
      tabs: [
        for (final tab in widget.tabs)
          TabMenuHorizontalOption(
            title: tab.title,
            badgeNumber: tab.badgeCount,
            icon: _currentIndex == widget.tabs.indexOf(tab)
                ? tab.iconSelected
                : tab.iconUnselected,
            value: widget.tabs.indexOf(tab),
          ),
      ],
    );
  }
}
