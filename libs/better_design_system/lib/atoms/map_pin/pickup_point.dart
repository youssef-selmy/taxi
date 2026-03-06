import 'package:better_design_system/atoms/map_pin/icon_point.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

typedef BetterPickupPoint = AppPickupPoint;

class AppPickupPoint extends StatelessWidget {
  const AppPickupPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppIconPoint(
      iconData: BetterIcons.gps01Filled,
      color: SemanticColor.tertiary,
    );
  }
}
