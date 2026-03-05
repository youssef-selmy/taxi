import 'package:better_design_system/molecules/date_picker_field/date_picker_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';

class DriverPendingVerificationReviewDocumentsOptionExpireDate
    extends StatelessWidget {
  const DriverPendingVerificationReviewDocumentsOptionExpireDate({
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
        final hasValidIndex =
            !state.driverDocumentsState.isLoading &&
            state.driverDocumentsExpireDateTime.length > index;

        return AppDatePickerField(
          validator: (value) {
            if (value == null) {
              return context.tr.fieldIsRequired;
            }
            // Validate date is in the future (after today)
            final today = DateTime.now();
            final todayDateOnly = DateTime(today.year, today.month, today.day);
            if (value.isBefore(todayDateOnly) ||
                value.isAtSameMomentAs(todayDateOnly)) {
              return 'Date must be in the future';
            }
            return null;
          },
          initialValue: hasValidIndex
              ? (state.driverDocumentsExpireDateTime[index] ?? DateTime.now())
              : DateTime.now(),
          onChanged: (value) {
            if (hasValidIndex) {
              bloc.onDriverDocumentsExpireDateTimeChange(index, value);
            }
          },
        );
      },
    );
  }
}
