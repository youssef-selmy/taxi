import 'package:flutter/material.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';

class PayoutMethodTitle extends StatelessWidget {
  final Fragment$payoutMethodCompact payoutMethod;

  const PayoutMethodTitle({super.key, required this.payoutMethod});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: kBorder(context),
          ),
          child: payoutMethod.media?.widget(width: 24, height: 24),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(payoutMethod.name, style: context.textTheme.bodyMedium),
            const SizedBox(height: 2),
            Text(
              context.tr.automaticPayoutToUserBankAccount,
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
      ],
    );
  }
}
