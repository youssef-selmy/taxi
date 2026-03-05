import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/components/weekdays_open_hours_input.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/blocs/park_spot_create.cubit.dart';

class ParkSpotCreateLocationOpenHours extends StatelessWidget {
  const ParkSpotCreateLocationOpenHours({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkSpotCreateBloc>();
    return SingleChildScrollView(
      child: BlocBuilder<ParkSpotCreateBloc, ParkSpotCreateState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsive(16, lg: 40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LargeHeader(title: context.tr.openHours),
                const Divider(height: 32),
                const SizedBox(height: 16),
                WeekdaysOpenHoursInput(
                  openHours: state.openHours,
                  onChanged: bloc.onOpenHoursChanged,
                ),
                const SizedBox(height: 32),
                LargeHeader(title: context.tr.location),
                const Divider(height: 32),
                const SizedBox(height: 16),
                SizedBox(
                  height: 500,
                  child: AppGenericMap(
                    hasSearchBar: true,
                    interactive: true,
                    mode: MapViewMode.picker,
                    centerMarkerBuilder: (context, key, address) =>
                        AppRodPin.centerMarker(key: key),
                    initialLocation: state.location
                        ?.toPlaceFragment(address: state.address ?? "-")
                        .toGenericMapPlace(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
