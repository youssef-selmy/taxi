import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';

import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/dialogs/driver_pending_verification_review_rejction_dialog.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverPendingVerificationReviewSoftReject extends StatelessWidget {
  const DriverPendingVerificationReviewSoftReject({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPendingVerificationReviewBloc>();
    return AppOutlinedButton(
      onPressed: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (_) {
            return BlocProvider.value(
              value: bloc,
              child: const DriverPendingVerificationReviewRejctionDialog(
                status: Enum$DriverStatus.SoftReject,
              ),
            );
          },
        );
      },
      text: context.tr.softReject,
      color: SemanticColor.neutral,
    );
  }
}
