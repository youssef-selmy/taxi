import 'package:better_localization/localizations.dart';
import 'package:flutter/widgets.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_settings/presentation/blocs/driver_settings.bloc.dart';
import 'package:better_icons/better_icons.dart';

class DriverSettingsWorkHoursRemoveShiftRule extends StatelessWidget {
  const DriverSettingsWorkHoursRemoveShiftRule({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return AppOutlinedButton(
      onPressed: () {
        context.read<DriverSettingsBloc>().removeShiftRule(index);
      },
      text: context.tr.removeShiftRule,
      color: SemanticColor.error,
      prefixIcon: BetterIcons.cancel01Outline,
    );
  }
}
