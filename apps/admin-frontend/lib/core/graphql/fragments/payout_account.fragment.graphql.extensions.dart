import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_account.fragment.graphql.dart';

extension PayoutAccountFragmentX on Fragment$payoutAccount {
  Widget tableView(BuildContext context) {
    return Row(
      children: [
        if (payoutMethod.media != null) ...[
          payoutMethod.media!.widget(width: 16, height: 16),
          const SizedBox(width: 4),
        ],
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${payoutMethod.name} ",
                style: context.textTheme.labelMedium?.variant(context),
              ),
              TextSpan(text: last4, style: context.textTheme.labelMedium),
            ],
          ),
        ),
      ],
    );
  }
}
