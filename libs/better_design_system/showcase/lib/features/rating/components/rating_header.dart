import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class RatingHeader extends StatelessWidget {
  final String title;
  const RatingHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 20,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: context.textTheme.labelLarge),
              Icon(
                BetterIcons.cancelCircleOutline,
                size: 20,
                color: context.colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
        AppDivider(),
      ],
    );
  }
}
