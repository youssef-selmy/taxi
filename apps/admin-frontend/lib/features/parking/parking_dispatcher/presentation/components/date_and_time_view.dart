import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/blocs/parking_dispatcher.cubit.dart';
import 'package:better_icons/better_icons.dart';

class DateAndTimeView extends StatelessWidget {
  const DateAndTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
      builder: (context, state) {
        return Row(
          children: [
            InfoChip(
              iconData: BetterIcons.calendar04Filled,
              text: state.selectedDate.formatDate(context),
            ),
            const SizedBox(width: 8),
            InfoChip(
              iconData: BetterIcons.clock01Filled,
              text:
                  "${context.tr.from} ${state.fromTime.format(context)} | ${context.tr.to} ${state.toTime.format(context)}",
            ),
          ],
        );
      },
    );
  }
}

class InfoChip extends StatelessWidget {
  final IconData iconData;
  final String text;

  const InfoChip({super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(iconData, size: 20, color: context.colors.primary),
          const SizedBox(width: 8),
          Text(text, style: context.textTheme.labelMedium),
        ],
      ),
    );
  }
}
