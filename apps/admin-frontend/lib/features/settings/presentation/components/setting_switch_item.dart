import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class SettingSwitchItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

  const SettingSwitchItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: context.textTheme.bodyMedium),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
