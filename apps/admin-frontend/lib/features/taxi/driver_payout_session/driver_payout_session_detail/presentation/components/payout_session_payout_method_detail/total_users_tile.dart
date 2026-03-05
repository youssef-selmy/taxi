import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/info_tile.dart';
import 'package:better_icons/better_icons.dart';

class TotalUsersTile extends StatelessWidget {
  final Fragment$taxiPayoutSessionPayoutMethodDetail payoutMethodDetail;

  const TotalUsersTile({super.key, required this.payoutMethodDetail});

  @override
  Widget build(BuildContext context) {
    return InfoTile(
      icon: BetterIcons.userMultipleFilled,
      title: context.tr.totalUsers,
      subtitle: Text(
        payoutMethodDetail.totalUsers.toString(),
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
