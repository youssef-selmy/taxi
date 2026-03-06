import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/fab/fab.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

typedef BetterMyLocationButton = AppMyLocationButton;

class AppMyLocationButton extends StatelessWidget {
  final Function() onPressed;

  const AppMyLocationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppFab.icon(
      size: ButtonSize.extraLarge,
      icon: BetterIcons.gps01Outline,
      color: SemanticColor.neutral,
      style: AppFabStyle.outline,
      onPressed: onPressed,
    );
  }
}
