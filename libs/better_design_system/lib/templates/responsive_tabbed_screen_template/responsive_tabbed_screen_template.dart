import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/entities/navigation_tab_item.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/templates/profile_screen_template/profile_screen_template.dart'
    show MobileNavigationMode;
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/entities/navigation_tab_item.dart';
export 'package:better_design_system/templates/profile_screen_template/profile_screen_template.dart'
    show MobileNavigationMode;

typedef BetterResponsiveTabbedScreenTemplate =
    AppResponsiveTabbedScreenTemplate;

class AppResponsiveTabbedScreenTemplate<T> extends StatefulWidget {
  final List<NavigationTabItem<T>> actions;
  final String title;
  final Function()? onMobileBackPressed;

  /// Controls mobile navigation behavior.
  /// - [MobileNavigationMode.embedded]: Detail views shown inline (default)
  /// - [MobileNavigationMode.route]: Calls [onDetailNavigate] for app to push route
  final MobileNavigationMode mobileNavigationMode;

  /// Called when a tab is tapped in route mode.
  /// The app should push a new route showing the detail view.
  /// Only used when [mobileNavigationMode] is [MobileNavigationMode.route].
  final void Function(T tab)? onDetailNavigate;

  const AppResponsiveTabbedScreenTemplate({
    super.key,
    required this.actions,
    required this.title,
    this.onMobileBackPressed,
    this.mobileNavigationMode = MobileNavigationMode.embedded,
    this.onDetailNavigate,
  });

  @override
  State<AppResponsiveTabbedScreenTemplate<T>> createState() =>
      _AppResponsiveTabbedScreenTemplateState<T>();
}

class _AppResponsiveTabbedScreenTemplateState<T>
    extends State<AppResponsiveTabbedScreenTemplate<T>> {
  T? selectedTab;

  NavigationTabItem<T>? get selectedAction =>
      widget.actions.firstWhereOrNull((action) => action.value == selectedTab);

  @override
  Widget build(BuildContext context) {
    return context.isDesktop ? buildDesktop(context) : buildMobile(context);
  }

  Widget buildDesktop(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: context.colors.surface),
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          children: [
            AppSidebarNavigation(
              expandedWidth: 300,
              header: Padding(
                padding: const EdgeInsets.only(top: 20, left: 12),
                child: Text(widget.title, style: context.textTheme.titleSmall),
              ),
              style: SidebarNavigationItemStyle.primary,
              selectedItem: selectedTab ?? widget.actions.firstOrNull?.value,

              onItemSelected: (tab) {
                setState(() {
                  selectedTab = tab;
                });
              },
              data: [
                for (var item in widget.actions)
                  NavigationItem(
                    value: item.value,
                    title: item.title,
                    badgeTitle: item.badge?.text,
                    icon: (item.icon, item.icon),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 88,
                  vertical: 24,
                ),
                child:
                    selectedAction?.child ??
                    widget.actions.firstOrNull?.child ??
                    const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    return switch (widget.mobileNavigationMode) {
      MobileNavigationMode.embedded => _buildMobileEmbedded(context),
      MobileNavigationMode.route => _buildMobileListView(context),
    };
  }

  Widget _buildMobileEmbedded(BuildContext context) {
    return PopScope(
      canPop: selectedTab == null,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          setState(() {
            selectedTab = null;
          });
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          final isDetail = child.key == const ValueKey('detail');
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: Offset(isDetail ? 1.0 : -1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: child,
          );
        },
        child: selectedTab != null
            ? _buildMobileDetailView(context, key: const ValueKey('detail'))
            : _buildMobileListView(context, key: const ValueKey('list')),
      ),
    );
  }

  Widget _buildMobileDetailView(BuildContext context, {Key? key}) {
    return DecoratedBox(
      key: key,
      decoration: BoxDecoration(color: context.colors.surface),
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppMobileTopBar(
              canPop: false,
              padding: const EdgeInsets.all(16),
              title: selectedAction?.title,
              onBackPressed: () {
                setState(() {
                  selectedTab = null;
                });
              },
            ),
          ),
          Expanded(child: selectedAction?.child ?? const SizedBox()),
        ],
      ),
    );
  }

  Widget _buildMobileListView(BuildContext context, {Key? key}) {
    return Container(
      key: key,
      color: context.colors.surface,
      child: SafeArea(
        child: Column(
          children: [
            AppMobileTopBar(
              padding: const EdgeInsets.all(16),
              title: widget.title,
              onBackPressed: () {
                widget.onMobileBackPressed?.call();
              },
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ...widget.actions
                      .map((item) {
                        return AppListItem(
                          title: item.title,
                          icon: item.icon,
                          isCompact: true,
                          badge: item.badge,
                          iconColor: SemanticColor.primary,
                          onTap: (_) {
                            switch (widget.mobileNavigationMode) {
                              case MobileNavigationMode.route:
                                widget.onDetailNavigate?.call(item.value);
                              case MobileNavigationMode.embedded:
                                setState(() {
                                  selectedTab = item.value;
                                });
                            }
                          },
                        );
                      })
                      .toList()
                      .separated(separator: const Divider(height: 24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
