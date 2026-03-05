import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class ChartIndicator extends StatelessWidget {
  final Color color;
  final String title;
  final IconData? icon;

  const ChartIndicator({
    super.key,
    required this.color,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon == null) ...[
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 8),
        ],
        if (icon != null) ...[
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 4),
        ],
        Text(title, style: context.textTheme.labelMedium),
      ],
    );
  }
}
