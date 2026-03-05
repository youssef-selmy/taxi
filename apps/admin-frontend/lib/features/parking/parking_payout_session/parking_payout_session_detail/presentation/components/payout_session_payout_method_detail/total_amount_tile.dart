import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_payout.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_payout_session/parking_payout_session_detail/presentation/components/payout_session_payout_method_detail/info_tile.dart';
import 'package:better_icons/better_icons.dart';

class TotalAmountTile extends StatelessWidget {
  final Fragment$parkingPayoutSessionPayoutMethodDetail payoutMethodDetail;

  const TotalAmountTile({super.key, required this.payoutMethodDetail});

  @override
  Widget build(BuildContext context) {
    return InfoTile(
      icon: BetterIcons.money03Filled,
      title: context.tr.totalAmountToBePaid,
      subtitle: Text(
        payoutMethodDetail.totalAmount.formatCurrency(
          payoutMethodDetail.payoutMethod.currency,
        ),
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
