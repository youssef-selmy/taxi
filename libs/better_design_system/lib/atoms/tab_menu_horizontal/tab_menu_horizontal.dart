import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_item.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_option.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal_style.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
export 'tab_menu_horizontal_option.dart';
export 'tab_menu_horizontal_style.dart';

typedef BetterTabMenuHorizontal = AppTabMenuHorizontal;

class AppTabMenuHorizontal<T> extends StatefulWidget {
  const AppTabMenuHorizontal({
    super.key,
    required this.tabs,
    this.controller,
    required this.selectedValue,
    this.style = TabMenuHorizontalStyle.nuetral,
    this.color = SemanticColor.neutral,
    required this.onChanged,
    this.isFullWidth = false,
  });

  final List<TabMenuHorizontalOption<T>> tabs;
  final T? selectedValue;
  final TabMenuHorizontalStyle style;
  final SemanticColor color;
  final TabController? controller;
  final void Function(T value)? onChanged;
  final bool isFullWidth;

  @override
  State<AppTabMenuHorizontal<T>> createState() =>
      _AppTabMenuHorizontalState<T>();
}

class _AppTabMenuHorizontalState<T> extends State<AppTabMenuHorizontal<T>>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(AppTabMenuHorizontal<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      _controller.index = widget.tabs.indexWhere(
        (e) => e.value == widget.selectedValue,
      );
    }
    if (oldWidget.tabs != widget.tabs) {
      _initController();
    }
  }

  void _initController() {
    final initialIndex = widget.tabs.indexWhere(
      (e) => e.value == widget.selectedValue,
    );
    _controller =
        widget.controller ??
        TabController(
          initialIndex: initialIndex < 0 ? 0 : initialIndex,
          length: widget.tabs.length,
          vsync: this,
        );
    _controller.addListener(() {
      if (_controller.indexIsChanging) return;
      final selected = widget.tabs[_controller.index].value;
      if (selected != widget.selectedValue) {
        widget.onChanged!(selected);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabBar = TabBar(
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.symmetric(
        horizontal: widget.style == TabMenuHorizontalStyle.soft ? 4 : 12,
      ),
      indicatorPadding: EdgeInsets.zero,
      isScrollable: true,
      tabAlignment: widget.isFullWidth
          ? TabAlignment.start
          : TabAlignment.center,
      indicator: hasIndicator
          ? UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 1,
                color: _getIndicatorColor() ?? context.colors.transparent,
              ),
            )
          : const UnderlineTabIndicator(borderSide: BorderSide.none),
      dividerHeight: hasIndicator ? 1 : 0,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 1,
      dividerColor: context.colors.outline,
      controller: _controller,
      overlayColor: WidgetStatePropertyAll(context.colors.transparent),
      splashFactory: NoSplash.splashFactory,
      enableFeedback: false,
      tabs: widget.tabs
          .asMap()
          .map((index, e) {
            return MapEntry(
              index,
              AppTabMenuHorizontalItem(
                item: e,
                selectedValue: widget.selectedValue,
                style: widget.style,
                color: widget.color,
                onPressed: (value) => widget.onChanged!(value as T),
              ),
            );
          })
          .values
          .toList(),
    );
    return DefaultTabController(
      length: widget.tabs.length,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [if (widget.isFullWidth) Expanded(child: tabBar) else tabBar],
      ),
    );
  }

  Color? _getIndicatorColor() {
    return switch (widget.style) {
      TabMenuHorizontalStyle.nuetral => context.colors.onSurface,
      TabMenuHorizontalStyle.primary => context.colors.primary,
      TabMenuHorizontalStyle.ghost ||
      TabMenuHorizontalStyle.soft ||
      TabMenuHorizontalStyle.fill => null,
    };
  }

  bool get hasIndicator {
    switch (widget.style) {
      case TabMenuHorizontalStyle.nuetral:
      case TabMenuHorizontalStyle.primary:
        return true;
      case TabMenuHorizontalStyle.ghost:
      case TabMenuHorizontalStyle.soft:
      case TabMenuHorizontalStyle.fill:
        return false;
    }
  }
}
