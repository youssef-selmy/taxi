import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation_logo.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSidebarNavigationLogo)
Widget appSidebarNavigationLogo(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSidebarNavigationLogo(
            isCollapsed: context.knobs.boolean(
              label: 'isCollapsed',
              initialValue: false,
            ),
            logoUrl: ImageFaker().appLogo.shop,
            title: 'Better',
            subtitle: 'subtitle',
            onPressed: () {},
          ),
          AppSidebarNavigationLogo(
            isCollapsed: context.knobs.boolean(
              label: 'isCollapsed',
              initialValue: false,
            ),
            logoUrl: ImageFaker().appLogo.shop,
            onPressed: () {},
            title: 'title',
          ),
        ],
      ),
    ],
  );
}
