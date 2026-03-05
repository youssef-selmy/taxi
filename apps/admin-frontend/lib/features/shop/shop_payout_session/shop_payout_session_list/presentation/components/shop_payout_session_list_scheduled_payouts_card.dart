import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class ShopPayoutSessionListScheduledPayoutsCard extends StatelessWidget {
  const ShopPayoutSessionListScheduledPayoutsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.tr.schedules, style: context.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: context.tr.numberOfActive(0)),
                  TextSpan(
                    text: context.tr.payoutSchedules,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      // TODO: Create new payout session
                    },
                    prefixIcon: BetterIcons.filterHorizontalOutline,
                    color: SemanticColor.neutral,
                    text: context.tr.setup,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
