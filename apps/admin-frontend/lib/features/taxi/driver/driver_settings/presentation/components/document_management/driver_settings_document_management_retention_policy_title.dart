import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DriverSettingsDocumentManagementRetentionPolicyTitle
    extends StatelessWidget {
  const DriverSettingsDocumentManagementRetentionPolicyTitle({
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
    return AppTextField(
      initialValue: retentionPolicy.title,
      hint: 'Title (Low Risk, Medium Risk, etc.)',
      onChanged: (value) {
        context.read<DriverSettingsBloc>().onRetentionPolicyOptionChange(
          documentIndex,
          retentionPolicyIndex,
          value,
        );
      },
      keyboardType: TextInputType.text,
      validator: FormBuilderValidators.required(),
    );
  }
}
