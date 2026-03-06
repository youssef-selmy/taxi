import 'package:better_design_system/atoms/navbar/navbar_logo.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppNavbarLogo)
Widget appNavbarLogo(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      AppNavbarLogo(
        logoUrl: ImageFaker().appLogo.shop,
        title: 'Better',
        subtitle: 'subtitle',
        onPressed: () {},
      ),
      AppNavbarLogo(logoUrl: ImageFaker().appLogo.shop, onPressed: () {}),
    ],
  );
}
