import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/blocs/driver_payout_session_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/dialogs/confirm_automatic_payout_dialog.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AutomaticPayoutButton extends StatelessWidget {
  const AutomaticPayoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      DriverPayoutSessionDetailBloc,
      DriverPayoutSessionDetailState
    >(
      builder: (context, state) {
        final isDisabled =
            state.selectedPayoutMethodState.data!.status !=
            Enum$PayoutSessionStatus.PENDING;
        return AppFilledButton(
          text: context.tr.payout,
          isDisabled: isDisabled,
          isLoading:
              state.selectedPayoutMethodState.data!.status ==
              Enum$PayoutSessionStatus.IN_PROGRESS,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ConfirmAutomaticPayoutDialog(
                  payoutMethod: state.selectedPayoutMethodState.data!,
                );
              },
            );
          },
        );
      },
    );
  }
}
