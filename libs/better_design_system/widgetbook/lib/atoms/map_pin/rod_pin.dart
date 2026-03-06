import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRodPin)
Widget defaultRodPin(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    spacing: 16,
    children: [
      AppRodPin(
        color: context.knobs.object.dropdown(
          label: 'Color',
          options: SemanticColor.values,
          initialOption: SemanticColor.primary,
        ),
      ),
      AppRodPin(
        iconData: BetterIcons.hamburger01Filled,
        color: context.knobs.object.dropdown(
          label: 'Color',
          options: SemanticColor.values,
          initialOption: SemanticColor.primary,
        ),
      ),
      AppRodPin(
        imageUrl: ImageFaker().person.four,
        color: context.knobs.object.dropdown(
          label: 'Color',
          options: SemanticColor.values,
          initialOption: SemanticColor.primary,
        ),
      ),
    ],
  );
}
