import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DriverSettingsWorkHoursMandatoryBreakMinutes extends StatelessWidget {
  const DriverSettingsWorkHoursMandatoryBreakMinutes({
    super.key,
    required this.driverShiftRule,
    required this.index,
  });

  final Fragment$driverShiftRule driverShiftRule;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AppNumberField.integer(
      hint: 'how many minutes should be the mandatory break',
      initialValue: driverShiftRule.mandatoryBreakMinutes,
      onChanged: (value) {
        context.read<DriverSettingsBloc>().onMandatoryBreakMinutesChange(
          index,
          value!,
        );
      },
      validator: FormBuilderValidators.aggregate([
        FormBuilderValidators.required(),
        FormBuilderValidators.min(0),
      ]),
    );
  }
}
