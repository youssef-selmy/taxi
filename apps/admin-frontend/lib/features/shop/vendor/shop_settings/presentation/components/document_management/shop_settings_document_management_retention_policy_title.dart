import 'package:admin_frontend/core/graphql/fragments/shop_document.fragment.graphql.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/shop/vendor/shop_settings/presentation/blocs/shop_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ShopSettingsDocumentManagementRetentionPolicyTitle
    extends StatelessWidget {
  const ShopSettingsDocumentManagementRetentionPolicyTitle({
    super.key,
    required this.retentionPolicy,
    required this.documentIndex,
    required this.retentionPolicyIndex,
  });

  final Fragment$shopDocumentRetentionPolicy retentionPolicy;
  final int documentIndex;
  final int retentionPolicyIndex;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      initialValue: retentionPolicy.title,
      hint: 'Title (Low Risk, Medium Risk, etc.)',
      onChanged: (value) {
        context.read<ShopSettingsBloc>().onRetentionPolicyOptionChange(
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
