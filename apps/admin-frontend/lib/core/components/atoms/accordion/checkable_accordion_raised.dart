import 'package:flutter/material.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class CheckableAccordionRaised extends StatelessWidget {
  final String title;
  final IconData? icon;

  final bool value;
  final Function(bool) onChanged;
  final Widget? child;

  const CheckableAccordionRaised({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        boxShadow: kShadow(context),
        borderRadius: BorderRadius.circular(8),
        border: kBorder(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Checkbox(
                value: value,
                onChanged: (value) => onChanged(value ?? false),
              ),
              const SizedBox(width: 16),
              if (icon != null) ...[
                Icon(icon, color: context.colors.primary, size: 20),
                const SizedBox(width: 8),
              ],
              Expanded(child: Text(title, style: context.textTheme.bodyMedium)),
            ],
          ),
          if (child != null && value) ...[const SizedBox(height: 16), child!],
        ],
      ),
    );
  }
}
