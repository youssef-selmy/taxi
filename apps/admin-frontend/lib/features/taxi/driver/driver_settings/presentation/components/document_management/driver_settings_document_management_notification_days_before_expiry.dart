import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DriverSettingsDocumentManagementNotificationDaysBeforeExpiry
    extends StatelessWidget {
  const DriverSettingsDocumentManagementNotificationDaysBeforeExpiry({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverSettingsBloc>();
    return BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
      builder: (context, state) {
        return AppNumberField.integer(
          initialValue:
              state.driverDocuments[index].notificationDaysBeforeExpiry,
          hint: '0',
          onChanged: (value) {
            bloc.onNotificationDaysBeforeExpiryChange(index, value!);
          },
          validator: FormBuilderValidators.required(),
        );
      },
    );
  }
}
