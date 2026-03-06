import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/organisms/expanded_profile_header/expanded_profile_header.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:better_icons/better_icon.dart';

import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

import '../../entities/navigation_tab_item.dart';

export '../../organisms/expanded_profile_header/kpi_item.dart';
export '../../entities/navigation_tab_item.dart';

enum ProfileHeaderBackgroundType { empty, roundedCircles }

/// Controls how mobile navigation works in profile templates.
enum MobileNavigationMode {
  /// Embedded mode (default): Detail views are shown inline with animated transitions.
  /// Uses PopScope to intercept Android back button.
  /// Note: iOS swipe-back gesture does not work in this mode (requires route navigation).
  embedded,

  /// Route mode: Detail views are pushed as separate routes by the app.
  /// The template only shows the list view and calls [onDetailNavigate] when
  /// user taps an item. The app is responsible for pushing the detail route.
  /// Fully supports iOS swipe-back and Android back button.
  route,
}

typedef BetterProfileScreenTemplate = AppProfileScreenTemplate;

class AppProfileScreenTemplate<T> extends StatelessWidget {
  final String? fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final String? email;
  final List<KpiItem> kpiItems;
  final List<NavigationTabItem<T>> actions;
  final Function()? onMobileBackPressed;
  final T selectedTab;
  final Function(T?) onTabSelected;
  final ProfileHeaderBackgroundType headerBackgroundType;

  /// Controls mobile navigation behavior.
  /// - [MobileNavigationMode.embedded]: Detail views shown inline (default)
  /// - [MobileNavigationMode.route]: Calls [onDetailNavigate] for app to push route
  final MobileNavigationMode mobileNavigationMode;

  /// Called when a tab is tapped in route mode.
  /// The app should push a new route showing the detail view.
  /// Only used when [mobileNavigationMode] is [MobileNavigationMode.route].
  final void Function(T tab)? onDetailNavigate;

  const AppProfileScreenTemplate({
    super.key,
    this.fullName,
    this.phoneNumber,
    this.avatarUrl,
    this.email,
    this.kpiItems = const [],
    this.actions = const [],
    this.onMobileBackPressed,
    required this.selectedTab,
    required this.onTabSelected,
    this.headerBackgroundType = ProfileHeaderBackgroundType.empty,
    this.mobileNavigationMode = MobileNavigationMode.embedded,
    this.onDetailNavigate,
  });

  NavigationTabItem<T>? get selectedAction =>
      actions.firstWhereOrNull((action) => action.value == selectedTab);

  @override
  Widget build(BuildContext context) {
    return context.isDesktop ? buildDesktop(context) : buildMobile(context);
  }

  Widget buildDesktop(BuildContext context) {
    return Center(
      child: Container(
        color: context.colors.surface,
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSidebarNavigation(
              expandedWidth: 300,
              header: Padding(
                padding: const EdgeInsets.only(top: 20, left: 12),
                child: Text(
                  context.strings.profile,
                  style: context.textTheme.titleSmall,
                ),
              ),
              style: SidebarNavigationItemStyle.primary,
              selectedItem: selectedTab ?? actions.firstOrNull?.value,
              onItemSelected: (tab) {
                onTabSelected(tab as T);
              },
              data: [
                for (var item in actions)
                  NavigationItem(
                    value: item.value,
                    title: item.title,
                    icon: (item.icon, item.icon),
                  ),
              ],
            ),
            Expanded(
              child:
                  selectedAction?.child ??
                  actions.firstOrNull?.child ??
                  const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMobile(BuildContext context) {
    return switch (mobileNavigationMode) {
      MobileNavigationMode.embedded => _buildMobileEmbedded(context),
      MobileNavigationMode.route => _buildMobileListView(context),
    };
  }

  Widget _buildMobileEmbedded(BuildContext context) {
    return PopScope(
      canPop: selectedTab == null,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          onTabSelected(null);
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
    return Container(
      key: key,
      color: context.colors.surface,
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: AppMobileTopBar(
              canPop: false,
              padding: const EdgeInsets.all(16),
              title: selectedAction?.title,
              onBackPressed: () {
                onTabSelected(null);
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
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              context.strings.profile,
              style: context.textTheme.titleSmall,
            ),
            leading: onMobileBackPressed != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppIconButton(
                      size: ButtonSize.medium,
                      style: IconButtonStyle.ghost,
                      icon: BetterIcons.arrowLeft02Outline,
                      onPressed: () {
                        onMobileBackPressed?.call();
                      },
                    ),
                  )
                : null,
            expandedHeight: 250 + (kpiItems.isNotEmpty ? 100 : 0),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: AppExpandedProfileHeader(
                title: fullName,
                subtitle: phoneNumber,
                avatarUrl: avatarUrl,
                isTitleMuted: fullName == null,
                kpiItems: kpiItems,
                headerBackgroundType: headerBackgroundType,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index >= actions.length) return null;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppListItem(
                      isCompact: true,
                      iconColor: actions[index].color,
                      title: actions[index].title,
                      onTap: (_) {
                        switch (mobileNavigationMode) {
                          case MobileNavigationMode.route:
                            onDetailNavigate?.call(actions[index].value);
                          case MobileNavigationMode.embedded:
                            onTabSelected(actions[index].value);
                        }
                      },
                      icon: actions[index].icon,
                    ),
                    if (index < actions.length - 1)
                      const AppDivider(height: 24),
                  ],
                );
              }, childCount: actions.length),
            ),
          ),
        ],
      ),
    );
  }
}
