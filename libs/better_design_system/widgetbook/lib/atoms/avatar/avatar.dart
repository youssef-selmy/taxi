import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppAvatar)
Widget defaultAvatar(BuildContext context) {
  return AppAvatar(
    statusBadgeType: context.knobs.object.dropdown(
      label: 'Status Badge Type',
      options: StatusBadgeType.values,
      description: 'Select the type of status badge to display',
      labelBuilder: (value) => value.name,
    ),
    size: context.knobs.object.dropdown(
      label: 'Size',
      options: AvatarSize.values,
      initialOption: AvatarSize.xxl24px,
      description: 'Select the size of the avatar',
      labelBuilder: (value) => value.name,
    ),
    placeholder: context.knobs.object.dropdown(
      label: 'Placeholder',
      options: AvatarPlaceholder.values,
      initialOption: AvatarPlaceholder.user,
      description: 'Select the placeholder type for the avatar',
      labelBuilder: (value) => value.name,
    ),
    shape: context.knobs.object.dropdown(
      label: 'Shape',
      options: AvatarShape.values,
      initialOption: AvatarShape.circle,
      description: 'Select the shape of the avatar',
      labelBuilder: (value) => value.name,
    ),
    enabledBorder: context.knobs.boolean(
      label: 'Enabled Border',
      description: 'Enable or disable the border of the avatar',
      initialValue: true,
    ),
    imageUrl: ImageFaker().food.burgerWithBlueBackground,
  );
}
