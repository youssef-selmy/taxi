import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/blocs/driver_payout_session_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_completed_notice.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/automatic_payout_button.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/insufficient_funds_notice.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_in_progress_notice.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_method_title.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/total_amount_tile.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/total_users_tile.dart';
import 'package:admin_frontend/schema.graphql.dart';

class PayoutMethodDetailDesktop extends StatelessWidget {
  const PayoutMethodDetailDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DriverPayoutSessionDetailBloc,
      DriverPayoutSessionDetailState
    >(
      builder: (context, state) {
        final payoutMethod = state.selectedPayoutMethodState.data!;
        return Column(
          children: [
            Row(
              children: [
                PayoutMethodTitle(payoutMethod: payoutMethod.payoutMethod),
                const SizedBox(width: 24),
                const InsufficientFundsNotice(),
                const Spacer(),
                if (payoutMethod.status ==
                    Enum$PayoutSessionStatus.IN_PROGRESS) ...[
                  const PayoutInProgressNotice(),
                  const SizedBox(width: 16),
                ],
                if (payoutMethod.status == Enum$PayoutSessionStatus.PAID) ...[
                  const PayoutCompletedNotice(),
                  const SizedBox(width: 16),
                ],
                const AutomaticPayoutButton(),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TotalUsersTile(payoutMethodDetail: payoutMethod),
                ),
                Expanded(
                  child: TotalAmountTile(payoutMethodDetail: payoutMethod),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
