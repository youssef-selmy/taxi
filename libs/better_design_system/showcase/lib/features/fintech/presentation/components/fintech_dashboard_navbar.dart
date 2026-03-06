import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class FintechDashboardNavbar extends StatelessWidget {
  const FintechDashboardNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        spacing: 12,
        children: [
          AppAvatar(
            imageUrl: ImageFaker().person.one,
            size: AvatarSize.size48px,
          ),
          Text('Hello, Robert 👋', style: context.textTheme.titleSmall),
          Spacer(),
          SizedBox(
            width: 270,
            child: AppTextField(
              density: TextFieldDensity.dense,
              hint: 'Search anything',
              prefixIcon: Icon(
                BetterIcons.search01Filled,
                color: context.colors.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
          AppNavbarIcon(icon: BetterIcons.filterHorizontalFilled),
          AppNavbarIcon(icon: BetterIcons.notification02Outline),
          AppFilledButton(
            onPressed: () {},
            text: 'Transfer Money',
            prefixIcon: BetterIcons.arrowDataTransferHorizontalFilled,
            color: SemanticColor.primary,
          ),
        ],
      ),
    );
  }
}
