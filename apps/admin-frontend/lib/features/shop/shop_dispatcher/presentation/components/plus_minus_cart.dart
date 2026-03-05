import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class PlusMinusCart extends StatelessWidget {
  final void Function(int) onChanged;
  final int quantity;

  const PlusMinusCart({
    super.key,
    required this.onChanged,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: context.colors.outline),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (quantity > 0) {
                onChanged(quantity - 1);
              }
            },
            icon: const Icon(BetterIcons.cancel01Outline, size: 16),
          ),
          Text(quantity.toString(), style: context.textTheme.labelMedium),
          IconButton(
            onPressed: () {
              onChanged(quantity + 1);
            },
            icon: const Icon(BetterIcons.addCircleOutline, size: 16),
          ),
        ],
      ),
    );
  }
}
