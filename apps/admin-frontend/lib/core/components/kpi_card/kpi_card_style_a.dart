import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class KPICardStyleA extends StatelessWidget {
  final String title;
  final IconData iconData;
  final String value;
  final Function()? onSeeMore;

  const KPICardStyleA({
    super.key,
    required this.title,
    required this.iconData,
    required this.value,
    required this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title, style: context.textTheme.labelMedium),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onSeeMore,
                  minimumSize: Size(0, 0),
                  child: Text(
                    context.tr.seeMore,
                    style: context.textTheme.labelMedium?.apply(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    iconData,
                    color: context.colors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(value, style: context.textTheme.headlineMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
