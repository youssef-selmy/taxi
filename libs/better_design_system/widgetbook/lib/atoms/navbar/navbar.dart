import 'package:better_design_system/atoms/navbar/navbar.dart';
import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:better_design_system/atoms/navbar/navbar_logo.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNavbar)
Widget appNavbar(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Row(
            children: [
              AppNavbar(
                prefix: AppNavbarLogo(logoUrl: ImageFaker().appLogo.shop),
                actions: [
                  AppNavbarActionItem(
                    title: 'Navbar',
                    icon: BetterIcons.settings01Outline,
                    badgeNumber: 3,
                    badgeTitle: 'badge',
                    style: NavbarActionItemStyle.nuetral,
                  ),
                  AppNavbarActionItem(
                    title: 'Navbar',
                    icon: BetterIcons.settings01Outline,
                    badgeNumber: 2,
                    style: NavbarActionItemStyle.nuetral,
                  ),
                  AppNavbarActionItem(
                    title: 'Navbar',
                    icon: BetterIcons.settings01Outline,
                    style: NavbarActionItemStyle.nuetral,
                    badgeTitle: 'badge',
                  ),
                  AppNavbarActionItem(
                    title: 'Navbar',
                    icon: BetterIcons.settings01Outline,
                    style: NavbarActionItemStyle.nuetral,
                  ),
                ],

                suffix: Row(
                  children: <Widget>[
                    AppToggleSwitchButtonGroup(
                      selectedValue: 0,
                      isRounded: true,
                      options: [
                        ToggleSwitchButtonGroupOption(
                          icon: BetterIcons.sun01Filled,
                          value: 1,
                        ),
                        ToggleSwitchButtonGroupOption(
                          icon: BetterIcons.moon02Outline,
                          value: 2,
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                    SizedBox(width: 16),
                    AppNavbarActionItem(icon: BetterIcons.search01Filled),
                    SizedBox(width: 8),
                    AppNavbarActionItem(
                      icon: BetterIcons.shoppingBag02Outline,
                      badgeNumber: 2,
                    ),
                    SizedBox(width: 8),
                    AppNavbarActionItem(
                      icon: BetterIcons.notification02Outline,
                      badgeNumber: 2,
                    ),

                    SizedBox(width: 16),
                    AppProfileButton(avatarUrl: ImageFaker().food.burger),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
