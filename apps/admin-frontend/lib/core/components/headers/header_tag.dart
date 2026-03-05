import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class HeaderTag extends StatelessWidget {
  final String text;

  const HeaderTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colors.onPrimary,
        ),
      ),
    );
  }
}
