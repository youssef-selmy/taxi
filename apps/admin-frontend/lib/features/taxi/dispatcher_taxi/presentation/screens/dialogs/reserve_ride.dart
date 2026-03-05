import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ReserveRideDialog extends StatelessWidget {
  const ReserveRideDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      icon: BetterIcons.clock01Filled,
      title: context.tr.reserveRide,
      subtitle: context.tr.pleaseSelectRideDateTime,
      onClosePressed: () => Navigator.of(context).pop(),
      primaryButton: AppFilledButton(
        text: context.tr.confirm,
        onPressed: () {
          context.read<DispatcherTaxiBloc>().onReserveRide();
          Navigator.of(context).pop();
        },
      ),
      secondaryButton: AppOutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: context.tr.cancel,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 175,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: DateTime.now().add(const Duration(minutes: 30)),
              initialDateTime: DateTime.now().add(const Duration(minutes: 30)),
              onDateTimeChanged: (DateTime newDateTime) {
                context.read<DispatcherTaxiBloc>().onReserveRideDateChanged(
                  newDateTime,
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              context.tr.confirmRequestScheduleNotice,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
