import 'package:better_design_system/atoms/avatar/avatar_group.dart';

import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppAvatarGroup)
Widget defaultAppAvatar(BuildContext context) {
  return AppAvatarGroup(
    isAvatarGroupBackgroundEnabled: context.knobs.boolean(
      label: 'Is Avatar Group Background Enabled',
      description: 'Enable or disable the background of the avatar group',
      initialValue: true,
    ),
    placeHolder: context.knobs.object.dropdown(
      label: 'Placeholder',
      options: AvatarPlaceholder.values,
      initialOption: AvatarPlaceholder.user,
      description: 'Select the placeholder type for the avatar group',
      labelBuilder: (value) => value.name,
    ),
    totalAvatars: context.knobs.int.slider(
      label: 'Total Avatars',
      description: 'Total number of avatars in the group',
      initialValue: 4,
      min: 1,
      max: 10,
    ),
    maxAvatars: context.knobs.int.slider(
      label: 'Max Avatars',
      initialValue: 3,
      description: 'Maximum number of avatars to display in the group',
      min: 1,
      max: 10,
    ),
    avatars: [
      ImageFaker().food.burger,
      ImageFaker().food.burgerWithBlueBackground,
      null,
    ],
    groupSize: context.knobs.object.dropdown(
      label: 'Group Size',
      options: AvatarGroupSize.values,
      description: 'Select the size of the avatar group',
      labelBuilder: (value) => value.name,
    ),
  );
}
