import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class PayoutCompletedNotice extends StatelessWidget {
  const PayoutCompletedNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          BetterIcons.checkmarkCircle02Filled,
          color: context.colors.success,
        ),
        const SizedBox(width: 16),
        Text(
          context.tr.payoutCompleted,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.success,
          ),
        ),
      ],
    );
  }
}
