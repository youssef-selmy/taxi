import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppProfileButton)
Widget appProfileButton(BuildContext context) {
  List<AppPopupMenuItem> items = [
    AppPopupMenuItem(
      title: 'Profile',
      onPressed: () {},
      icon: BetterIcons.userFilled,
    ),
    AppPopupMenuItem(
      title: 'Profile',
      onPressed: () {},
      icon: BetterIcons.wallet01Filled,
    ),
    AppPopupMenuItem(
      hasDivider: true,
      title: 'Logout',
      onPressed: () {},
      icon: BetterIcons.logout01Filled,
      color: SemanticColor.error,
    ),
  ];
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 200,
    children: [
      AppProfileButton(
        items: items,
        avatarUrl: ImageFaker().food.burger,
        title: 'User name',
        subtitle: 'Sublabel',
      ),
      AppProfileButton(avatarUrl: ImageFaker().food.burger, items: items),
    ],
  );
}
