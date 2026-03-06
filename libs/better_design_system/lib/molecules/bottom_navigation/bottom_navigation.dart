import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation_fab.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation_item.dart';

const double _kBottomNavHeight = 88.0;
const double _kHorizontalPadding = 16.0;
const double _kItemSpacing = 8.0;
const double _kFabPlaceholderWidth = 64.0;

enum BottomNavType { normal, blur }

enum PrimaryActionPosition { none, middle, floating }

class NavigationItem<T> {
  final Widget icon;
  final Widget? activeIcon;
  final String? label;
  final int? badgeCount;
  final Widget? badge;
  final SemanticColor color;
  final bool isDisabled;
  final T value;

  const NavigationItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.badgeCount,
    this.badge,
    this.color = SemanticColor.primary,
    this.isDisabled = false,
    required this.value,
  });
}

typedef BetterBottomNavigation = AppBottomNavigation;

class AppBottomNavigation<T> extends StatefulWidget {
  final List<NavigationItem<T>> items;
  final BottomNavType type;
  final PrimaryActionPosition primaryActionPosition;
  final BottomNavFab<T>? primaryAction;
  final ValueChanged<T> onTap;
  final T? selectedValue;

  const AppBottomNavigation({
    super.key,
    required this.items,
    this.type = BottomNavType.normal,
    this.primaryActionPosition = PrimaryActionPosition.none,
    this.primaryAction,
    required this.onTap,
    this.selectedValue,
  }) : assert(items.length >= 2 && items.length <= 5);

  @override
  State<AppBottomNavigation<T>> createState() => _AppBottomNavigationState<T>();
}

class _AppBottomNavigationState<T> extends State<AppBottomNavigation<T>> {
  Widget _buildItems() {
    final List<Widget> navItems = widget.items.map<Widget>((item) {
      final bool isSelected = widget.selectedValue == item.value;
      return Expanded(
        child: AppBottomNavigationItem<T>(
          icon: item.icon,
          activeIcon: item.activeIcon,
          label: item.label,
          badgeCount: item.badgeCount,
          badge: item.badge,
          selected: isSelected,
          color: item.color,
          isDisabled: item.isDisabled,
          displayType: BottomNavItemDisplayType.withoutContainerHorizontal,
          value: item.value,
          onPressed: () => widget.onTap(item.value),
        ),
      );
    }).toList();

    final hasPrimaryAction = widget.primaryAction != null;
    final middleIndex = (widget.items.length / 2).ceil();

    if (hasPrimaryAction &&
        widget.primaryActionPosition == PrimaryActionPosition.middle) {
      navItems.insert(middleIndex, widget.primaryAction!);
    } else if (hasPrimaryAction &&
        widget.primaryActionPosition == PrimaryActionPosition.floating) {
      navItems.insert(
        middleIndex,
        const SizedBox(width: _kFabPlaceholderWidth),
      );
    }

    final List<Widget> children = [];
    for (int i = 0; i < navItems.length; i++) {
      children.add(navItems[i]);
      if (i < navItems.length - 1) {
        children.add(const SizedBox(width: _kItemSpacing));
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildBackground(BuildContext context) {
    if (widget.type == BottomNavType.blur) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
          child: Container(color: context.colors.surface.withAlpha(200)),
        ),
      );
    }
    return Container(color: context.colors.surface);
  }

  @override
  Widget build(BuildContext context) {
    final isBlurType = widget.type == BottomNavType.blur;

    final decoration = BoxDecoration(
      color: isBlurType ? context.colors.transparent : context.colors.surface,
      border: Border(
        top: BorderSide(
          width: 1,
          color: isBlurType
              ? context.colors.surfaceVariant
              : context.colors.outline,
        ),
      ),
    );

    return Container(
      height: _kBottomNavHeight + MediaQuery.paddingOf(context).bottom,
      decoration: decoration,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: _buildBackground(context)),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: _kHorizontalPadding,
              ),
              child: _buildItems(),
            ),
          ),
          if (widget.primaryAction != null &&
              widget.primaryActionPosition == PrimaryActionPosition.floating)
            Positioned(top: -9, child: widget.primaryAction!),
        ],
      ),
    );
  }
}
