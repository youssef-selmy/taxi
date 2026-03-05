import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class ApplicationItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final bool isAvailable;

  const ApplicationItem({
    super.key,
    required this.imagePath,
    required this.text,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Opacity(
            opacity: isAvailable ? 1 : 0.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(imagePath, width: 24, height: 24),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isAvailable
                    ? context.colors.onSurface
                    : context.colors.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          Icon(
            isAvailable
                ? BetterIcons.checkmarkCircle02Filled
                : BetterIcons.cancelCircleFilled,
            color: isAvailable ? context.colors.success : context.colors.error,
          ),
        ],
      ),
    );
  }
}
