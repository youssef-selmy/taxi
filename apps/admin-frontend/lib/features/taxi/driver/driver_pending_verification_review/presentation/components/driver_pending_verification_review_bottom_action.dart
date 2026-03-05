import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_hard_reject.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_soft_reject.dart';
import 'package:better_icons/better_icons.dart';

class DriverPendingVerificationRreviewBottomAction extends StatelessWidget {
  const DriverPendingVerificationRreviewBottomAction({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPendingVerificationReviewBloc>();
    return BlocBuilder<
      DriverPendingVerificationReviewBloc,
      DriverPendingVerificationReviewState
    >(
      builder: (context, state) {
        return Column(
          children: [
            if (state.stepperCurrentIndex == 2) ...[
              context.responsive(
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DriverPendingVerificationReviewHardReject(),
                    SizedBox(width: 16),
                    DriverPendingVerificationReviewSoftReject(),
                  ],
                ),
                lg: const SizedBox(),
              ),
              context.responsive(
                const SizedBox(height: 8),
                lg: const SizedBox(),
              ),
            ],
            Row(
              children: <Widget>[
                if (state.stepperCurrentIndex > 0)
                  AppOutlinedButton(
                    onPressed: () {
                      bloc.onPreviousPage();
                    },
                    text: context.tr.back,
                    prefixIcon: BetterIcons.arrowLeft02Outline,
                  ),
                Spacer(),
                state.stepperCurrentIndex == 2
                    ? Row(
                        children: [
                          context.responsive(
                            const SizedBox(),
                            lg: const Row(
                              children: [
                                DriverPendingVerificationReviewHardReject(),
                                SizedBox(width: 16),
                                DriverPendingVerificationReviewSoftReject(),
                                SizedBox(width: 16),
                              ],
                            ),
                          ),
                          AppFilledButton(
                            text: context.tr.approve,
                            onPressed: () {
                              bloc.onApproveDriver();
                            },
                          ),
                        ],
                      )
                    : AppFilledButton(
                        text: 'Continue',
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? true) {
                            bloc.onNextPage();
                          }
                        },
                      ),
              ],
            ),
          ],
        );
      },
    );
  }
}
