import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation_fab.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// Define an enum for type-safe navigation routes
enum NavRoute { home, offers, cart, orders, profile }

@UseCase(name: 'Default', type: AppBottomNavigation)
Widget bottomNavUseCase(BuildContext context) {
  final navType = context.knobs.object.dropdown<BottomNavType>(
    label: 'Navigation Type',
    options: BottomNavType.values,
    initialOption: BottomNavType.normal,
    labelBuilder: (value) => value.name,
  );

  final primaryActionPosition = context.knobs.object
      .dropdown<PrimaryActionPosition>(
        label: 'Primary Action Position',
        options: PrimaryActionPosition.values,
        initialOption: PrimaryActionPosition.none,
        labelBuilder: (value) => value.name,
      );

  final allItems = [
    NavigationItem<NavRoute>(
      value: NavRoute.home,
      icon: Icon(BetterIcons.home01Outline),
      activeIcon: Icon(BetterIcons.home01Filled),
      label: 'Home',
    ),
    NavigationItem<NavRoute>(
      value: NavRoute.offers,
      icon: Icon(BetterIcons.couponPercentOutline),
      activeIcon: Icon(BetterIcons.couponPercentFilled),
      label: 'Offers',
      badgeCount: 2,
    ),
    NavigationItem<NavRoute>(
      value: NavRoute.cart,
      icon: Icon(BetterIcons.shoppingBasket03Outline),
      activeIcon: Icon(BetterIcons.shoppingBasket03Filled),
      label: 'Cart',
      badgeCount: 2,
    ),
    NavigationItem<NavRoute>(
      value: NavRoute.orders,
      icon: Icon(BetterIcons.bookOpen01Outline),
      activeIcon: Icon(BetterIcons.bookOpen01Filled),
      label: 'Orders',
    ),
    NavigationItem<NavRoute>(
      value: NavRoute.profile,
      icon: Icon(BetterIcons.userOutline),
      activeIcon: Icon(BetterIcons.userFilled),
      label: 'Profile',
    ),
  ];

  NavRoute selectedValue = NavRoute.home;

  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      final isFabActive = primaryActionPosition != PrimaryActionPosition.none;

      final items =
          isFabActive
              ? allItems.where((item) => item.value != NavRoute.cart).toList()
              : allItems;

      final fab =
          isFabActive
              ? BottomNavFab<NavRoute>(
                value: NavRoute.cart,
                icon: Icon(BetterIcons.shoppingBasket03Outline),
                selected: selectedValue == NavRoute.cart,
                onPressed: () => setState(() => selectedValue = NavRoute.cart),
              )
              : null;

      return Padding(
        padding: const EdgeInsets.all(200),
        child: AppBottomNavigation<NavRoute>(
          items: items,
          type: navType,
          primaryActionPosition: primaryActionPosition,
          primaryAction: fab,
          selectedValue: selectedValue,
          onTap: (value) => setState(() => selectedValue = value),
        ),
      );
    },
  );
}
