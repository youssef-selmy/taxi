import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge_options.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar.dart';
import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class EcommerceNavbarSecond extends StatelessWidget {
  const EcommerceNavbarSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppNavbar(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          prefix: Row(
            children: [
              Assets.images.logo.image(
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 12),
              Text('Better', style: context.textTheme.titleSmall),
            ],
          ),
          suffix: Row(
            children: [
              SizedBox(
                width: 260,
                child: AppTextField(
                  density: TextFieldDensity.noDense,
                  hint: 'Search',
                  prefixIcon: Icon(
                    BetterIcons.search01Filled,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              AppIconButton(
                icon: BetterIcons.favouriteOutline,
                style: IconButtonStyle.outline,
                size: ButtonSize.medium,
                iconSize: 22,
                iconColor: context.colors.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              AppIconButton(
                icon: BetterIcons.shoppingBag02Outline,
                style: IconButtonStyle.outline,
                size: ButtonSize.medium,
                iconSize: 22,
                iconColor: context.colors.onSurfaceVariant,
                dotBadge: DotBadgeOptions(count: 2),
              ),
              const SizedBox(width: 16),
              AppProfileButton(
                avatarUrl: ImageFaker().person.four,
                title: 'Justin Schleifer',
                items: [
                  AppPopupMenuItem(
                    title: 'Profile',
                    onPressed: () {},
                    icon: BetterIcons.userFilled,
                  ),
                  AppPopupMenuItem(
                    title: 'Profile',
                    onPressed: () {},
                    icon: BetterIcons.wallet01Filled,
                  ),
                  AppPopupMenuItem(
                    hasDivider: true,
                    title: 'Logout',
                    onPressed: () {},
                    icon: BetterIcons.logout01Filled,
                    color: SemanticColor.error,
                  ),
                ],
              ),
            ],
          ),
        ),
        AppNavbar(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          prefix: Row(
            children: [
              AppNavbarActionItem(
                icon: BetterIcons.menu01Outline,
                onPressed: () {},
                title: 'Categories',
              ),
              const SizedBox(width: 6),
              AppNavbarActionItem(
                icon: BetterIcons.discountTag02Outline,
                onPressed: () {},
                title: 'Hot Sale',
              ),
              const SizedBox(width: 6),
              AppNavbarActionItem(
                icon: BetterIcons.flashOutline,
                onPressed: () {},
                title: 'Best Sellers',
              ),
            ],
          ),
          suffix: Row(
            children: [
              AppTextButton(
                onPressed: () {},
                text: 'Cordova',
                prefix: Icon(BetterIcons.location01Outline, size: 20),
                size: ButtonSize.medium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
