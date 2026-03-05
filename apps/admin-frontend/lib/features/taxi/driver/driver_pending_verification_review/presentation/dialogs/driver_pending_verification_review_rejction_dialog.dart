import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverPendingVerificationReviewRejctionDialog extends StatelessWidget {
  const DriverPendingVerificationReviewRejctionDialog({
    super.key,
    required this.status,
  });
  final Enum$DriverStatus status;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPendingVerificationReviewBloc>();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: AppResponsiveDialog(
        primaryButton: AppFilledButton(
          color: SemanticColor.primary,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.router.maybePop();
              bloc.onDriverRejection(status);
            }
          },
          text: context.tr.sendMessages,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        maxWidth: 648,
        icon: BetterIcons.alertCircleFilled,
        title: context.tr.reasonOfRejection,
        onClosePressed: () {
          context.router.maybePop();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppTextField(
              label: context.tr.rejectionMessageToDriver,
              hint: context.tr.writeYourMessageHere,
              onChanged: bloc.onRejectionNoteChange,
              maxLines: 5,
            ),
            const SizedBox(height: 8),
            Text(
              context.tr.rejectionMessageWillBeSentToDriver,
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const Divider(height: 32),
            AppTextField(
              label: context.tr.rejectionMessageToStaff,
              hint: context.tr.writeYourMessageHere,
              onChanged: bloc.onRejectionNoteToStaffChange,
              maxLines: 5,
            ),
            const SizedBox(height: 8),
            Text(
              context.tr.messageVisibleToStaffOnly,
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
      ),
    );
  }
}
