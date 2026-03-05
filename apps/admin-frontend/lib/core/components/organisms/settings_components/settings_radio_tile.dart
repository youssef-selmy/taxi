import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class AppSettingsRadioTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final VoidCallback? onSelected;

  const AppSettingsRadioTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected?.call(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRadio(
            value: value,
            groupValue: true,
            onTap: (_) => onSelected?.call(),
            size: RadioSize.small,
          ),
          const SizedBox(width: 8),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.labelLarge),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: context.textTheme.bodySmall?.variant(context),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
