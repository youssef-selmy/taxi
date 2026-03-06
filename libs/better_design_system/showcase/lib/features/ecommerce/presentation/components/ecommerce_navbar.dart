import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceNavbar extends StatelessWidget {
  final List<Widget> leftItems;
  final List<Widget> rightItems;
  final EdgeInsets padding;

  const EcommerceNavbar({
    super.key,
    required this.leftItems,
    required this.rightItems,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
  });

  /// Style 1: Dashboard Panel Rounded
  factory EcommerceNavbar.dashboardPanelRounded() {
    return EcommerceNavbar(
      leftItems: [
        Builder(
          builder: (context) {
            return SizedBox(
              width: 358,
              child: AppTextField(
                density: TextFieldDensity.noDense,
                hint: 'Search anything',
                prefixIcon: Icon(
                  BetterIcons.search01Filled,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            );
          },
        ),
      ],
      rightItems: [
        AppNavbarIcon(
          icon: BetterIcons.notification02Outline,
          badgeNumber: 2,
          size: ButtonSize.medium,
          iconSize: 24,
        ),
        const SizedBox(width: 16),
        AppOutlinedButton(
          onPressed: () {},
          text: 'View Shop',
          prefixIcon: BetterIcons.store01Outline,
          color: SemanticColor.neutral,
        ),
      ],
    );
  }

  /// Style 2: Dashboard Panel Circular
  factory EcommerceNavbar.dashboardPanelCircular() {
    return EcommerceNavbar(leftItems: [], rightItems: []);
  }

  // /// Style 3: Client Side
  // factory EcommerceNavbar.clientSide() {
  //   return EcommerceNavbar(leftItems: [], rightItems: []);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(children: [...leftItems, const Spacer(), ...rightItems]),
    );
  }
}
