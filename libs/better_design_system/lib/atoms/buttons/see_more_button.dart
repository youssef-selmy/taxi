import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter/cupertino.dart';

typedef BetterSeeMoreButton = AppSeeMoreButton;

class AppSeeMoreButton extends StatelessWidget {
  final void Function()? onPressed;
  const AppSeeMoreButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      size: ButtonSize.small,
      onPressed: onPressed,
      text: 'See more',
    );
  }
}
