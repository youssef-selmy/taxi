import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class PayoutInProgressNotice extends StatelessWidget {
  const PayoutInProgressNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(BetterIcons.loading03Outline, color: context.colors.warning),
        const SizedBox(width: 16),
        Text(
          context.tr.payoutInProgress,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.warning,
          ),
        ),
      ],
    );
  }
}
