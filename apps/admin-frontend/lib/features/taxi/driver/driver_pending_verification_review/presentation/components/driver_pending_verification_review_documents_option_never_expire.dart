import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';

class DriverPendingVerificationReviewDocumentsOptionNeverExpire
    extends StatelessWidget {
  const DriverPendingVerificationReviewDocumentsOptionNeverExpire({
    super.key,
    required this.index,
  });

  final int index;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPendingVerificationReviewBloc>();
    return BlocBuilder<
      DriverPendingVerificationReviewBloc,
      DriverPendingVerificationReviewState
    >(
      builder: (context, state) {
        // Defensive check for list bounds
        final isValidIndex =
            !state.driverDocumentsState.isLoading &&
            state.driverDocumentsExpireDate.length > index;

        return Row(
          children: <Widget>[
            SizedBox(
              height: 18,
              width: 18,
              child: AppCheckbox(
                value: isValidIndex
                    ? state.driverDocumentsExpireDate[index]
                    : false,
                onChanged: (value) {
                  if (isValidIndex) {
                    bloc.onDriverDocumentExpireDateChange(index, value);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(context.tr.neverExpires, style: context.textTheme.bodyMedium),
          ],
        );
      },
    );
  }
}
