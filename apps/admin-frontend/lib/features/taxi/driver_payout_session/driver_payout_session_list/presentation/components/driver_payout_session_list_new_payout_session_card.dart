import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/new_batch_payout_session_dialog/presentation/dialogs/new_batch_payout_session_dialog.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverPayoutSessionListNewPayoutSessionCard extends StatelessWidget {
  const DriverPayoutSessionListNewPayoutSessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.tr.newPayoutSession,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              context.tr.createPayoutSessionByUserCriteria,
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        useSafeArea: false,
                        builder: (context) => const NewBatchPayoutSessionDialog(
                          appType: Enum$AppType.Taxi,
                        ),
                      );
                    },
                    prefixIcon: BetterIcons.arrowDown03Outline,
                    color: SemanticColor.neutral,
                    text: context.tr.create,
                  ),
                ),
                // const SizedBox(
                //   width: 16,
                // ),
                // Expanded(
                //   child: AppOutlinedButton(
                //     onPressed: () {
                //
                //     },
                //     title: "Manual",
                //     type: Buttonype.neutral,
                //     prefixIcon: BetterIcons.userMultipleOutline,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
