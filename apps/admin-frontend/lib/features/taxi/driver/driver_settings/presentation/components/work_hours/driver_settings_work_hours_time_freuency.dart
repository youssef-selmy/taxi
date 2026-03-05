import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/time_frequency_enum.dart';
import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverSettingsWorkHoursTimeFrequency extends StatelessWidget {
  const DriverSettingsWorkHoursTimeFrequency({
    super.key,
    required this.driverShiftRule,
    required this.index,
  });

  final Fragment$driverShiftRule driverShiftRule;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverSettingsBloc>();
    return BlocBuilder<DriverSettingsBloc, DriverSettingsState>(
      builder: (context, state) {
        return AppDropdownField.single(
          hint: context.tr.selectOption,
          initialValue: driverShiftRule.timeFrequency,
          items: Enum$TimeFrequency.values
              .where((e) => e != Enum$TimeFrequency.$unknown)
              .map((e) => AppDropdownItem(title: e.name(context), value: e))
              .toList(),
          onChanged: (value) {
            bloc.onTimeFrequencyChange(index, value);
          },
          validator: (value) {
            return null;
          },
        );
      },
    );
  }
}
