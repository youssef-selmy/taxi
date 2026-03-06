import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/large_action_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppLargeActionButton)
Widget defaultLargeActionButton(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppLargeActionButton(
      title: "Taxi",
      size: context.knobs.object.dropdown<LargeActionButtonSize>(
        label: 'Size',
        options: LargeActionButtonSize.values,
        initialOption: LargeActionButtonSize.large,
        labelBuilder: (value) => value.name,
      ),
      onPressed: () {},
      imagePath: Assets.images.avatars.illustration01.path,
      imagePackage: Assets.package,
    ),
  );
}
