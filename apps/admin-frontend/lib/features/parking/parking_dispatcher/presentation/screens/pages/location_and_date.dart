import 'package:better_design_system/atoms/input_fields/time_field/time_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/blocs/parking_dispatcher.cubit.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/components/customer_profile.dart';
import 'package:better_icons/better_icons.dart';

class LocationAndDate extends StatelessWidget {
  const LocationAndDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: context.pagePaddingHorizontal,
          child: CustomerProfile(),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: context.pagePaddingHorizontal,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.tr.selectLocation,
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            BlocBuilder<
                              ParkingDispatcherBloc,
                              ParkingDispatcherState
                            >(
                              builder: (context, state) {
                                return AppGenericMap(
                                  interactive: true,
                                  hasSearchBar: true,
                                  mode: MapViewMode.picker,
                                  enableAddressResolve: true,
                                  centerMarkerBuilder: (context, key, address) {
                                    return AppRodPin.centerMarkerDestination(
                                      key: key,
                                    );
                                  },
                                  onMapMoved: (event) => context
                                      .read<ParkingDispatcherBloc>()
                                      .onMapMoved(event.place),
                                  initialLocation: state.selectedDestination
                                      ?.toGenericMapPlace(),
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.selectDateAndTime,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colors.outline),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocBuilder<
                            ParkingDispatcherBloc,
                            ParkingDispatcherState
                          >(
                            builder: (context, state) {
                              return CalendarDatePicker(
                                initialDate: state.selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 5),
                                ),
                                onDateChanged: (date) {
                                  context
                                      .read<ParkingDispatcherBloc>()
                                      .dateChanged(date);
                                },
                              );
                            },
                          ),
                          BlocBuilder<
                            ParkingDispatcherBloc,
                            ParkingDispatcherState
                          >(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.tr.from,
                                        style: context.textTheme.labelMedium,
                                      ),
                                      const SizedBox(height: 2),
                                      AppTimeField(
                                        defaultValue: state.fromTime,
                                        onChanged: (value) {
                                          context
                                              .read<ParkingDispatcherBloc>()
                                              .fromTimeChanged(value);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.tr.to,
                                        style: context.textTheme.labelMedium,
                                      ),
                                      const SizedBox(height: 2),
                                      AppTimeField(
                                        defaultValue: state.toTime,
                                        onChanged: (value) {
                                          context
                                              .read<ParkingDispatcherBloc>()
                                              .toTimeChanged(value);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 48),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.outline),
            color: context.colors.surface,
            boxShadow: kBottomBarShadow(context),
          ),
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                AppOutlinedButton(
                  prefixIcon: BetterIcons.arrowLeft02Outline,
                  onPressed: context.read<ParkingDispatcherBloc>().goBack,
                  text: context.tr.back,
                ),
                const Spacer(),
                BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
                  builder: (context, state) {
                    return AppFilledButton(
                      isDisabled: state.selectedDestination == null,
                      onPressed: context
                          .read<ParkingDispatcherBloc>()
                          .onAddressConfirmed,
                      text: context.tr.actionContinue,
                      suffixIcon: BetterIcons.arrowRight02Outline,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
