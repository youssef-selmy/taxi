import 'package:better_design_system/atoms/avatar/spaced_avatar_group.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSpacedAvatarGroup)
Widget defaultSpacedAvatarGroup(BuildContext context) {
  return AppSpacedAvatarGroup(
    size: context.knobs.object.dropdown(
      label: 'Size',
      options: AvatarSize.values,
      initialOption: AvatarSize.xxl24px,
      description: 'Select the size of the avatars',
    ),
    imageUrls: [
      ImageFaker().person.one,
      ImageFaker().person.two,
      ImageFaker().person.three,
      ImageFaker().person.four,
      ImageFaker().person.five,
      ImageFaker().person.six,
    ],
    maxImages: context.knobs.int.slider(
      label: 'Max Images',
      initialValue: 6,
      min: 1,
      max: 6,
      divisions: 5,
      description: 'Select the maximum number of images to display',
    ),
    count: context.knobs.int.slider(
      label: 'Count',
      initialValue: 4,
      min: 1,
      max: 100,
      divisions: 5,
      description: 'Select the total number of avatars',
    ),
  );
}
