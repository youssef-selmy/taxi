import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'soft', type: AppTag)
Widget tagSoft(BuildContext context) {
  return appTag(context, TagStyle.soft);
}

@UseCase(name: 'outline', type: AppTag)
Widget tagOutline(BuildContext context) {
  return appTag(context, TagStyle.outline);
}

@UseCase(name: 'fill', type: AppTag)
Widget tagFill(BuildContext context) {
  return appTag(context, TagStyle.fill);
}

@UseCase(name: 'roundedSoft', type: AppTag)
Widget softRoundedTag(BuildContext context) {
  return appTag(context, TagStyle.soft, rounded: true);
}

@UseCase(name: 'roundedOutline', type: AppTag)
Widget outlineRoundedTag(BuildContext context) {
  return appTag(context, TagStyle.outline, rounded: true);
}

@UseCase(name: 'roundedFill', type: AppTag)
Widget fillRoundedTag(BuildContext context) {
  return appTag(context, TagStyle.fill, rounded: true);
}

Widget appTag(BuildContext context, TagStyle style, {bool rounded = false}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 20,
    children: [
      AppTag(
        isDisabled: context.knobs.isDisabled,
        isRounded: rounded,
        style: style,
        text: 'Tag',
        color: context.knobs.semanticColor,
        size: context.knobs.tagSize,
        onRemovedPressed: () {},
      ),

      AppTag(
        isDisabled: context.knobs.isDisabled,
        isRounded: rounded,
        style: style,
        text: 'Tag',
        prefixIcon: BetterIcons.clock01Filled,
        color: context.knobs.semanticColor,
        size: context.knobs.tagSize,
        onRemovedPressed: () {},
      ),

      AppTag(
        isDisabled: context.knobs.isDisabled,
        isRounded: rounded,
        style: style,
        text: 'Tag',
        prefixImage: ImageFaker().food.burger,
        color: context.knobs.semanticColor,
        size: context.knobs.tagSize,
        onRemovedPressed: () {},
      ),
    ],
  );
}
