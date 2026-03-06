import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

enum EcommerceNavRoute { home, wishlist, shippingCart, profile }

class EcommerceBottomNav extends StatefulWidget {
  const EcommerceBottomNav({
    super.key,
    this.selectedItem = EcommerceNavRoute.home,
  });

  final EcommerceNavRoute selectedItem;

  @override
  State<EcommerceBottomNav> createState() => _EcommerceBottomNavState();
}

class _EcommerceBottomNavState extends State<EcommerceBottomNav> {
  late EcommerceNavRoute _selectedRoute;

  @override
  void initState() {
    super.initState();
    _selectedRoute = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomNavigation<EcommerceNavRoute>(
      items: [
        NavigationItem(
          icon: const Icon(BetterIcons.home01Outline),
          activeIcon: const Icon(BetterIcons.home01Filled),
          label: 'Home',
          value: EcommerceNavRoute.home,
        ),
        NavigationItem(
          icon: const Icon(BetterIcons.favouriteOutline),
          activeIcon: const Icon(BetterIcons.favouriteFilled),
          value: EcommerceNavRoute.wishlist,
          label: 'Wishlist',
        ),
        NavigationItem(
          icon: const Icon(BetterIcons.shoppingBag02Outline),
          activeIcon: const Icon(BetterIcons.shoppingBag02Filled),
          value: EcommerceNavRoute.shippingCart,
          label: 'Shopping Cart',
          badgeCount: 2,
        ),
        NavigationItem(
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Assets.images.avatars.illustration01.image(
              width: 24,
              height: 24,
            ),
          ),
          value: EcommerceNavRoute.profile,
          label: 'Profile',
        ),
      ],
      selectedValue: _selectedRoute,
      onTap: (value) => setState(() => _selectedRoute = value),
    );
  }
}
