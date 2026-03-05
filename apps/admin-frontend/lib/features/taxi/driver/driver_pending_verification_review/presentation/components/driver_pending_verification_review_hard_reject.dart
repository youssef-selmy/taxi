import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/dialogs/driver_pending_verification_review_rejction_dialog.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverPendingVerificationReviewHardReject extends StatelessWidget {
  const DriverPendingVerificationReviewHardReject({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPendingVerificationReviewBloc>();
    return CupertinoButton(
      onPressed: () {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (_) {
            return BlocProvider.value(
              value: bloc,
              child: const DriverPendingVerificationReviewRejctionDialog(
                status: Enum$DriverStatus.HardReject,
              ),
            );
          },
        );
      },
      child: Text(
        context.tr.hardReject,
        style: context.textTheme.labelMedium?.apply(
          color: context.colors.error,
        ),
      ),
    );
  }
}
