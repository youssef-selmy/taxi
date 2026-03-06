import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

typedef BetterMenuButton = AppMenuButton;

class AppMenuButton extends StatelessWidget {
  final void Function()? onPressed;
  const AppMenuButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: onPressed,
      icon: BetterIcons.moreHorizontalCircle01Filled,
      style: IconButtonStyle.ghost,
    );
  }
}
