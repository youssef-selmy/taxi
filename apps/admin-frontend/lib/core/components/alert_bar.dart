import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class AppAlertBar extends StatelessWidget {
  final String text;

  const AppAlertBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: context.colors.successContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              BetterIcons.checkmarkCircle02Filled,
              color: context.isDark ? Colors.white : context.colors.success,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              text,
              style: TextStyle(
                color: context.isDark ? Colors.white : context.colors.success,
              ),
            ),
          ),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}
