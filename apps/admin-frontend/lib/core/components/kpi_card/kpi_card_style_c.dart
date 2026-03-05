import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class KPICardStyleC extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final String value;

  const KPICardStyleC({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textTheme.labelMedium),
            Text(
              subtitle,
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(iconData, color: context.colors.primary),
                const SizedBox(width: 8),
                Text(value, style: context.textTheme.titleMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
