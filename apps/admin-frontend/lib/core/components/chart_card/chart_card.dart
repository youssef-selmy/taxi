import 'package:flutter/material.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? footer;
  final Widget child;
  final double? height;
  final List<Widget> filters;

  const ChartCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.footer,
    this.height,
    this.filters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(12),
        boxShadow: kShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(title, style: context.textTheme.labelMedium),
                ),
                ...filters.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: e,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              subtitle,
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ),
          const SizedBox(height: 36),
          Expanded(child: child),
          const SizedBox(height: 16),
          if (footer != null) ...[
            const Divider(),
            Padding(padding: const EdgeInsets.all(16), child: footer!),
          ],
        ],
      ),
    );
  }
}
