import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';

class DriverPendingVerificationReviewDocumentsOptionRetentionPolicy
    extends StatelessWidget {
  const DriverPendingVerificationReviewDocumentsOptionRetentionPolicy({
    super.key,
    required this.document,
    required this.index,
  });

  final Fragment$driverToDriverDocument document;
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
        final documents =
            state.driverDocumentsState.data?.driverToDriverDocuments.edges
                .map((e) => e.node)
                .toList() ??
            <Fragment$driverToDriverDocument>[];
        final currentRetentionPolicyId = (documents.length > index)
            ? documents[index].retentionPolicy?.id
            : null;

        return AppDropdownField.single(
          initialValue: document.driverDocument.retentionPolicies
              .firstWhereOrNull((e) => e.id == currentRetentionPolicyId),
          hint: context.tr.selectOption,
          items: document.driverDocument.retentionPolicies
              .map((e) => AppDropdownItem(title: e.title, value: e))
              .toList(),
          onChanged: (value) {
            bloc.onDriverDocumenRetentionPolicyChange(index, value);
          },
        );
      },
    );
  }
}
