import 'package:better_design_system/atoms/sidebar_navigation/enum/sidebar_navigation_item_style.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_item.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_section.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';
export 'navigation_item.dart';
export 'enum/sidebar_navigation_item_style.dart';

typedef BetterSidebarNavigation = AppSidebarNavigation;

class AppSidebarNavigation<T> extends StatefulWidget {
  final T selectedItem;
  final Function(T) onItemSelected;
  final Widget? header;
  final Widget? footer;
  final List<NavigationItem<T>> data;
  final SidebarNavigationItemStyle style;
  final List<SidebarNavigationSection> sections;
  final bool collapsable;
  final bool isCollapsed;
  final double expandedWidth;
  final double collapsedWidth;
  final double? itemHorizontalPadding;
  final Function(bool isCollapsed)? onCollapseChanged;
  final bool showDivider;

  const AppSidebarNavigation({
    super.key,
    required this.selectedItem,
    this.isCollapsed = false,
    required this.onItemSelected,
    this.header,
    this.data = const [],
    this.style = SidebarNavigationItemStyle.fill,
    this.sections = const [],
    this.footer,
    this.collapsable = false,
    this.expandedWidth = 290,
    this.collapsedWidth = 100,
    this.itemHorizontalPadding,
    this.onCollapseChanged,
    this.showDivider = false,
  });

  @override
  createState() => _AppSidebarNavigationState<T>();
}

class _AppSidebarNavigationState<T> extends State<AppSidebarNavigation<T>> {
  late bool isCollapsed;
  T? expandedItem;

  @override
  void initState() {
    isCollapsed = widget.isCollapsed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isCollapsed ? widget.collapsedWidth : widget.expandedWidth,
      child: Stack(
        alignment: Alignment.topRight,
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: !isCollapsed
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    // Fixed Header
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: !isCollapsed
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          if (widget.header != null) ...[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: !isCollapsed ? double.infinity : 140,
                              ),
                              child: widget.header!,
                            ),
                            const SizedBox(height: 16),
                          ],
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),

                    // Scrollable Middle Section
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: !isCollapsed
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: <Widget>[
                            ...() {
                              final Map<String?, List<NavigationItem<T>>>
                              groupedItems = {};
                              for (final item in widget.data) {
                                final sectionKey = item.section?.title;
                                groupedItems
                                    .putIfAbsent(sectionKey, () => [])
                                    .add(item);
                              }

                              final List<Widget> allWidgets = [];

                              groupedItems.forEach((sectionTitle, items) {
                                if (sectionTitle != null && !isCollapsed) {
                                  allWidgets.add(
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            widget.itemHorizontalPadding ?? 24,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        sectionTitle,
                                        style: context.textTheme.labelLarge
                                            ?.copyWith(
                                              color: context
                                                  .colors
                                                  .onSurfaceVariantLow,
                                            ),
                                      ),
                                    ),
                                  );
                                }

                                for (final item in items) {
                                  allWidgets.add(
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            widget.itemHorizontalPadding ??
                                            (!isCollapsed ? 24 : 8),
                                      ),
                                      child: AppSidebarNavigationItem<T>(
                                        isItemExpanded:
                                            expandedItem == item.value,
                                        isCollapsed: isCollapsed,
                                        item: item,
                                        collapsedWidth: widget.collapsedWidth,
                                        onItemSelected: (value) =>
                                            widget.onItemSelected(value),
                                        selectedItem: widget.selectedItem,
                                        style: widget.style,
                                        onItemExpansionChanged: (p0, p1) {
                                          setState(() {
                                            expandedItem = p1
                                                ? item.value
                                                : null;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                  allWidgets.add(const SizedBox(height: 4));
                                }
                              });

                              return allWidgets;
                            }(),
                          ],
                        ),
                      ),
                    ),

                    // Fixed Footer
                    if (widget.footer != null) widget.footer!,
                  ],
                ),
              ),
              // Vertical Divider
              if (widget.showDivider)
                Container(width: 1, color: context.colors.outline),
            ],
          ),
          if (widget.collapsable)
            Positioned(
              top: 23,
              right: -12,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                  if (widget.onCollapseChanged != null) {
                    widget.onCollapseChanged!(isCollapsed);
                  }
                },
                minimumSize: const Size(0, 0),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: Border.all(width: 1, color: context.colors.outline),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.shadow,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    turns: isCollapsed ? 0.5 : 0,
                    child: Icon(
                      BetterIcons.arrowLeft01Outline,
                      size: 20,
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
