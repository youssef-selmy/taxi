import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';

extension PayoutMethodCompactX on Fragment$payoutMethodCompact {
  Widget tableView(BuildContext context) {
    return Row(
      children: [
        media.widget(width: 24, height: 24),
        const SizedBox(width: 8),
        Text(name, style: context.textTheme.labelMedium),
      ],
    );
  }
}
