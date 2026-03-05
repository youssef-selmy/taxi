import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class BenefitItem extends StatelessWidget {
  final String text;
  final bool isAvailable;

  const BenefitItem({super.key, required this.text, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isAvailable ? BetterIcons.tick02Filled : BetterIcons.cancel01Outline,
          color: isAvailable ? context.colors.success : context.colors.error,
        ),
        const SizedBox(width: 8),
        Text(text, style: context.textTheme.labelMedium),
      ],
    );
  }
}
