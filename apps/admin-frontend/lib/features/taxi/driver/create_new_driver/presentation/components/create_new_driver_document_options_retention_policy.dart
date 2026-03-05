import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';

class CreateNewDriverDocumentOptionsRetentionPolicy extends StatelessWidget {
  const CreateNewDriverDocumentOptionsRetentionPolicy({
    super.key,
    required this.document,
    required this.index,
  });

  final Fragment$driverDocument document;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewDriverBloc>();
    return AppDropdownField.single(
      validator: (value) {
        if (value == null) {
          return context.tr.fieldIsRequired;
        }
        return null;
      },
      hint: context.tr.selectOption,
      items: document.retentionPolicies
          .map((e) => AppDropdownItem(title: e.title, value: e))
          .toList(),
      onChanged: (value) {
        bloc.onDriverDocumenRetentionPolicyChange(index, value);
      },
    );
  }
}
