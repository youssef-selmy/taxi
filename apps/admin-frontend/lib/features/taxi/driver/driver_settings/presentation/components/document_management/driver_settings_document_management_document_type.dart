import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DriverSettingsDocumentManagementDocumentType extends StatelessWidget {
  const DriverSettingsDocumentManagementDocumentType({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverSettingsBloc>();
    return BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
      builder: (context, state) {
        return AppTextField(
          initialValue: state.driverDocuments[index].title,
          hint: context.tr.enterType,
          onChanged: (value) {
            bloc.onDocumentTitleChange(index, value);
          },
          keyboardType: TextInputType.number,
          validator: FormBuilderValidators.required(),
        );
      },
    );
  }
}
