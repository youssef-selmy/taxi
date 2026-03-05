import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DriverSettingsDocumentManagementRetentionPolicyDeleteAfter
    extends StatelessWidget {
  const DriverSettingsDocumentManagementRetentionPolicyDeleteAfter({
    super.key,
    required this.retentionPolicy,
    required this.documentIndex,
    required this.retentionPolicyIndex,
  });

  final Fragment$driverDocumentRetentionPolicy retentionPolicy;
  final int documentIndex;
  final int retentionPolicyIndex;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverSettingsBloc>();
    return BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
      builder: (context, state) {
        return AppNumberField.integer(
          hint: 'x days',
          initialValue: retentionPolicy.deleteAfterDays,
          onChanged: (value) {
            bloc.onRetentionPolicyDeleteAfterChange(
              documentIndex,
              retentionPolicyIndex,
              value!,
            );
          },
          validator: FormBuilderValidators.required(),
        );
      },
    );
  }
}
