import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/tab_bar_bordered/tab_item_bordered.dart';

class TabBarBordered<T> extends StatefulWidget {
  final List<TabBarItem<T>> items;
  final T? selectedValue;
  final void Function(T value)? onSelected;

  const TabBarBordered({
    super.key,
    required this.items,
    this.selectedValue,
    this.onSelected,
  });

  @override
  State<TabBarBordered<T>> createState() => _TabBarBorderedState<T>();
}

class _TabBarBorderedState<T> extends State<TabBarBordered<T>> {
  T? _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.items
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TabItemBordered(
                title: e.title,
                prefixIcon: e.prefixIcon,
                prefixWidget: e.prefixWidget,
                value: e.value,
                selectedValue: _selectedValue,
                onSelected: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                  widget.onSelected?.call(value);
                },
              ),
            ),
          )
          .toList(),
    );
  }
}

class TabBarItem<T> {
  final String title;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final T value;

  TabBarItem({
    required this.title,
    this.prefixIcon,
    this.prefixWidget,
    required this.value,
  });
}
