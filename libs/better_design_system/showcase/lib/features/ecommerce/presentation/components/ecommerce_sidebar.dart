import 'package:better_design_showcase/features/ecommerce/entities/ecommerce_sidebar_page.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_logo.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_user_profile.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

export 'package:better_design_showcase/features/ecommerce/entities/ecommerce_sidebar_page.dart';

class EcommerceSidebar extends StatelessWidget {
  const EcommerceSidebar({
    super.key,
    this.selectedItem = EcommerceSidebarPage.dashboard,
    this.showDivider = true,
  });

  final EcommerceSidebarPage selectedItem;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: AppSidebarNavigation<EcommerceSidebarPage>(
        expandedWidth: 272,
        showDivider: showDivider,
        header: AppSidebarNavigationLogo(
          logoUrl: ImageFaker().appLogo.taxi,
          title: 'E-Commerce',
        ),
        style: SidebarNavigationItemStyle.primary,
        data: [
          NavigationItem(
            title: 'Dashboard',
            value: EcommerceSidebarPage.dashboard,
            icon: (BetterIcons.home01Outline, BetterIcons.home01Filled),
          ),
          NavigationItem(
            title: 'Orders',
            value: EcommerceSidebarPage.orders,
            icon: (
              BetterIcons.shoppingCart01Outline,
              BetterIcons.shoppingCart01Filled,
            ),
          ),
          NavigationItem(
            title: 'Products',
            value: EcommerceSidebarPage.products,
            icon: (
              BetterIcons.dashboardSquare01Outline,
              BetterIcons.dashboardSquare01Filled,
            ),
            subItems: [
              NavigationSubItem(
                title: 'List',
                value: EcommerceSidebarPage.productsList,
              ),
              NavigationSubItem(
                title: 'Categories',
                value: EcommerceSidebarPage.productCategories,
              ),
            ],
          ),
          NavigationItem(
            title: 'Inventory',
            value: EcommerceSidebarPage.inventory,
            icon: (
              BetterIcons.deliveryBox01Outline,
              BetterIcons.deliveryBox01Filled,
            ),
          ),
          NavigationItem(
            title: 'Customers',
            value: EcommerceSidebarPage.customers,
            icon: (
              BetterIcons.userMultipleOutline,
              BetterIcons.userMultipleFilled,
            ),
          ),
          NavigationItem(
            title: 'Promotions',
            value: EcommerceSidebarPage.promotions,
            icon: (
              BetterIcons.discountTag02Outline,
              BetterIcons.discountTag02Filled,
            ),
          ),
          NavigationItem(
            title: 'Payment',
            value: EcommerceSidebarPage.payment,
            icon: (BetterIcons.money03Outline, BetterIcons.money03Filled),
          ),
          NavigationItem(
            title: 'Message',
            value: EcommerceSidebarPage.message,
            icon: (BetterIcons.mail02Outline, BetterIcons.mail02Filled),
            badgeTitle: '124',
          ),
          NavigationItem(
            title: 'More',
            value: EcommerceSidebarPage.more,
            icon: (
              BetterIcons.moreHorizontalCircle01Outline,
              BetterIcons.moreHorizontalCircle01Filled,
            ),
            subItems: [
              NavigationSubItem(
                title: 'Settings',
                value: EcommerceSidebarPage.more,
              ),
            ],
          ),
        ],
        selectedItem: selectedItem,
        onItemSelected: (value) {},
        footer: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppDivider(),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: AppSidebarNavigationUserProfile(
                  avatarUrl: ImageFaker().person.seven,
                  style: SidebarNavigationUserProfileStyle.soft,
                  title: 'Gustavo Kenter',
                  subtitle: 'Gustavo@better.com',
                  onPressed: () {},
                  icon: BetterIcons.moreVerticalCircle01Outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
