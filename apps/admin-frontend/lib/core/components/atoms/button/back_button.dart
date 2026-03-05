import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/buttons/icon_button.dart';

import 'package:better_icons/better_icons.dart';

class AppBackButton extends StatelessWidget {
  final void Function() onPressed;

  const AppBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: onPressed,
      icon: BetterIcons.arrowLeft02Outline,
    );
  }
}
