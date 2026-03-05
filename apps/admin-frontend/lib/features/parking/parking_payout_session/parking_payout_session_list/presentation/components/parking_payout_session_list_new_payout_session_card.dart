import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/new_batch_payout_session_dialog/presentation/dialogs/new_batch_payout_session_dialog.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingPayoutSessionListNewPayoutSessionCard extends StatelessWidget {
  const ParkingPayoutSessionListNewPayoutSessionCard({super.key});

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
                          appType: Enum$AppType.Parking,
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
                //       // TODO: Create new payout session
                //     },
                //     title: "Manual",
                //     color: SemanticColor.neutral,
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
