import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterEmptyState = AppEmptyState;

class AppEmptyState extends StatelessWidget {
  final AssetGenImage image;
  final String title;
  final String? actionText;
  final Function()? onActionPressed;

  const AppEmptyState({
    super.key,
    required this.image,
    required this.title,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Spacer(),
          image.image(width: 150, height: 150),
          const SizedBox(height: 24),
          Text(
            "“ $title ”",
            style: context.textTheme.bodyLarge?.variant(context),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          if (actionText != null)
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: SafeArea(
                top: false,
                child: AppOutlinedButton(
                  text: actionText!,
                  onPressed: onActionPressed,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
