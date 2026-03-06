import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'soft', type: AppBadge)
Widget badgeSoft(BuildContext context) {
  return appBadge(context, BadgeStyle.soft);
}

@UseCase(name: 'outline', type: AppBadge)
Widget badgeOutline(BuildContext context) {
  return appBadge(context, BadgeStyle.outline);
}

@UseCase(name: 'fill', type: AppBadge)
Widget badgeFill(BuildContext context) {
  return appBadge(context, BadgeStyle.fill);
}

@UseCase(name: 'roundedSoft', type: AppBadge)
Widget softRoundedBadge(BuildContext context) {
  return appBadge(context, BadgeStyle.soft, rounded: true);
}

@UseCase(name: 'roundedOutline', type: AppBadge)
Widget outlineRoundedBadge(BuildContext context) {
  return appBadge(context, BadgeStyle.outline, rounded: true);
}

@UseCase(name: 'roundedFill', type: AppBadge)
Widget fillRoundedBadge(BuildContext context) {
  return appBadge(context, BadgeStyle.fill, rounded: true);
}

Widget appBadge(
  BuildContext context,
  BadgeStyle style, {
  bool rounded = false,
}) {
  final badgeSize = context.knobs.object.dropdown(
    label: 'Size',
    description: 'Select the badge size',
    options: BadgeSize.values,
    labelBuilder: (value) => value.name,
    initialOption: BadgeSize.medium,
  );
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 20,
    children: [
      AppBadge(
        isDisabled: context.knobs.isDisabled,
        isRounded: rounded,
        style: style,
        text: 'Badge',
        prefixImage: ImageFaker().food.burger,
        color: context.knobs.semanticColor,
        size: badgeSize,
      ),
      AppBadge(
        isDisabled: context.knobs.isDisabled,
        isRounded: rounded,
        style: style,
        text: 'Badge',
        prefixIcon: Icons.favorite,
        suffixIcon: Icons.favorite,
        color: context.knobs.semanticColor,
        size: badgeSize,
      ),
      AppBadge(
        isDisabled: context.knobs.isDisabled,
        isRounded: rounded,
        style: style,
        hasDot: true,
        text: 'Badge',
        color: context.knobs.semanticColor,
        size: badgeSize,
      ),
      AppBadge(
        isDisabled: context.knobs.isDisabled,
        isRounded: rounded,
        style: style,
        text: 'Badge',
        color: context.knobs.semanticColor,
        size: badgeSize,
      ),
    ],
  );
}
