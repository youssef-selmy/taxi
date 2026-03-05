import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/payout_method_type.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/blocs/driver_payout_session_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_completed_notice.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/automatic_payout_button.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/export_to_csv_button.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/insufficient_funds_notice.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_in_progress_notice.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_method_title.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/total_amount_tile.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/total_users_tile.dart';
import 'package:admin_frontend/schema.graphql.dart';

class PayoutMethodDetailMobile extends StatelessWidget {
  const PayoutMethodDetailMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DriverPayoutSessionDetailBloc,
      DriverPayoutSessionDetailState
    >(
      builder: (context, state) {
        final payoutMethod = state.selectedPayoutMethodState.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PayoutMethodTitle(payoutMethod: payoutMethod.payoutMethod),
            const SizedBox(height: 24),
            if (state.isFundsSufficient == false) ...[
              const InsufficientFundsNotice(),
              const SizedBox(height: 24),
            ],
            if (payoutMethod.status ==
                Enum$PayoutSessionStatus.IN_PROGRESS) ...[
              const PayoutInProgressNotice(),
              const SizedBox(height: 24),
            ],
            if (payoutMethod.status == Enum$PayoutSessionStatus.PAID) ...[
              const PayoutCompletedNotice(),
              const SizedBox(width: 24),
            ],
            if (payoutMethod.payoutMethod.type.isAutomatic)
              const AutomaticPayoutButton(),
            if (!payoutMethod.payoutMethod.type.isAutomatic)
              const ExportToCsvButton(),
            const SizedBox(height: 24),
            TotalUsersTile(payoutMethodDetail: payoutMethod),
            const SizedBox(height: 24),
            TotalAmountTile(payoutMethodDetail: payoutMethod),
          ],
        );
      },
    );
  }
}
