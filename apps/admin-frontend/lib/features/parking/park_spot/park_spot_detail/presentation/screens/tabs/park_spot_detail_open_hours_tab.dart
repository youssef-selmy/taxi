import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/weekdays_open_hours_input.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail.cubit.dart';

class ParkSpotDetailOpenHoursTab extends StatelessWidget {
  const ParkSpotDetailOpenHoursTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkSpotDetailBloc>();
    return BlocBuilder<ParkSpotDetailBloc, ParkSpotDetailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LargeHeader(title: context.tr.openHours),
              const Divider(height: 32),
              const SizedBox(height: 16),
              WeekdaysOpenHoursInput(
                openHours: state.parkSpotDetailState.data!.weeklySchedule
                    .toInput(),
                onChanged: bloc.onOpenHoursChanged,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: AppFilledButton(
                  onPressed: bloc.saveOpenHours,
                  text: context.tr.saveChanges,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
