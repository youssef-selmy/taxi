import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class RatingIndicator extends StatelessWidget {
  final int? rating;

  const RatingIndicator({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(BetterIcons.starFilled, color: context.colors.warning, size: 16),
        const SizedBox(width: 4),
        Text(
          rating == null ? "-" : ((rating! / 20).toStringAsFixed(1)),
          style: context.textTheme.bodySmall,
        ),
        Text("/5", style: context.textTheme.bodySmall?.variant(context)),
      ],
    );
  }
}
