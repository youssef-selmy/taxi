import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class FeatureTitle extends StatelessWidget {
  final String title;
  const FeatureTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariantLow,
        border: Border(bottom: BorderSide(color: context.colors.outline)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.textTheme.titleSmall),
          AppIconButton(
            icon: BetterIcons.cancelCircleOutline,
            style: IconButtonStyle.outline,
            iconColor: context.colors.onSurface,
            size: ButtonSize.medium,
            onPressed: () {
              context.router.pop();
            },
          ),
        ],
      ),
    );
  }
}
