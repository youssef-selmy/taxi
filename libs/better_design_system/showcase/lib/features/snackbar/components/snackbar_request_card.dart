import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class SnackbarRequestCard extends StatelessWidget {
  const SnackbarRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 462,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colors.outline),
        color: context.colors.surface,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow,
            blurRadius: 80,
            spreadRadius: -8,
            offset: Offset(0, 24),
          ),
        ],
      ),
      child: Row(
        spacing: 8,
        children: [
          AppAvatar(
            imageUrl: ImageFaker().person.eight,
            size: AvatarSize.size40px,
          ),
          Text(
            'Terry Korsgaard Sent a Request',
            style: context.textTheme.labelLarge,
          ),
          AppFilledButton(
            onPressed: () {},
            text: 'Accept',
            size: ButtonSize.medium,
          ),
          AppTextButton(
            onPressed: () {},
            text: 'Decline',
            size: ButtonSize.medium,
          ),
          AppIconButton(
            icon: BetterIcons.cancel01Outline,
            size: ButtonSize.medium,
          ),
        ],
      ),
    );
  }
}
