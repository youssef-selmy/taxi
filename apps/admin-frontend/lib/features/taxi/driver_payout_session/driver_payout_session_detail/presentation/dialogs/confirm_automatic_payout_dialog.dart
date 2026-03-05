import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_payout.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/blocs/driver_payout_session_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/payout_method_title.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/total_amount_tile.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_detail/presentation/components/payout_session_payout_method_detail/total_users_tile.dart';
import 'package:better_icons/better_icons.dart';

class ConfirmAutomaticPayoutDialog extends StatelessWidget {
  final Fragment$taxiPayoutSessionPayoutMethodDetail payoutMethod;

  const ConfirmAutomaticPayoutDialog({super.key, required this.payoutMethod});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverPayoutSessionDetailBloc(),
      child:
          BlocBuilder<
            DriverPayoutSessionDetailBloc,
            DriverPayoutSessionDetailState
          >(
            builder: (context, state) {
              return AppResponsiveDialog(
                onClosePressed: () => Navigator.of(context).pop(),
                primaryButton: AppFilledButton(
                  text: context.tr.confirmPayout,
                  onPressed: () {
                    context
                        .read<DriverPayoutSessionDetailBloc>()
                        .runAutoPayout();
                  },
                ),
                secondaryButton: AppOutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: context.tr.cancel,
                ),
                icon: BetterIcons.alertCircleFilled,
                title: context.tr.payoutConfirmation,
                subtitle: "${context.tr.pleaseReviewInformationAndConfirm}:",
                child: Column(
                  children: [
                    PayoutMethodTitle(payoutMethod: payoutMethod.payoutMethod),
                    const SizedBox(height: 24),
                    TotalUsersTile(payoutMethodDetail: payoutMethod),
                    const SizedBox(height: 24),
                    TotalAmountTile(payoutMethodDetail: payoutMethod),
                  ],
                ),
              );
            },
          ),
    );
  }
}
