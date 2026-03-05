import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget subtitle;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: context.colors.primary, size: 20),
            const SizedBox(width: 10),
            Text(title, style: context.textTheme.labelMedium?.variant(context)),
          ],
        ),
        const SizedBox(height: 8),
        subtitle,
      ],
    );
  }
}
