import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSidebarNavigationUserProfile)
Widget defaultAppSidebarNavigationUserProfile(BuildContext context) {
  return AppSidebarNavigationUserProfile(
    avatarUrl: ImageFaker().food.burger,
    onPressed: () {},
  );
}

@UseCase(name: 'With Title', type: AppSidebarNavigationUserProfile)
Widget appSidebarUserProfile(BuildContext context) {
  return SizedBox(
    width: 200,
    child: AppSidebarNavigationUserProfile(
      avatarUrl: ImageFaker().food.burger,
      title: 'title',
      subtitle: 'subtitle',
      onPressed: () {},
    ),
  );
}
