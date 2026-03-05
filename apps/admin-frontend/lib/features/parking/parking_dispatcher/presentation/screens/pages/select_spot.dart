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
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/components/parking_marker.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/components/parkings_list.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/screens/dialogs/confirm_parking_order.dart';
import 'package:better_icons/better_icons.dart';

class SelectSpot extends StatefulWidget {
  const SelectSpot({super.key});

  @override
  State<SelectSpot> createState() => _SelectSpotState();
}

class _SelectSpotState extends State<SelectSpot> {
  MapViewController? mapViewController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: CustomerProfile(),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(left: 40, right: 40, bottom: 32),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child:
                      BlocConsumer<
                        ParkingDispatcherBloc,
                        ParkingDispatcherState
                      >(
                        listener: (context, state) {
                          if (state.selectedDestination != null &&
                              state.parkings.isLoaded) {
                            mapViewController?.fitBounds([
                              state.selectedDestination!.point.toLatLngLib(),
                              ...state.parkings.data!.map(
                                (e) => e.location.toLatLngLib(),
                              ),
                            ]);
                          }
                        },
                        builder: (context, state) {
                          return AppGenericMap(
                            padding: const EdgeInsets.all(32),
                            initialLocation: state.selectedDestination
                                ?.toGenericMapPlace(),
                            onControllerReady: (p0) {
                              mapViewController = p0;
                            },
                            markers: [
                              if (state.selectedDestination != null)
                                AppRodPin.markerDestination(
                                  id: 'center_marker',
                                  position: state.selectedDestination!.point
                                      .toLatLngLib(),
                                ),
                              ...state.parkings.data?.map((e) {
                                    return ParkingMarker(
                                      price: e.carPrice ?? 0.0,
                                      currency: e.currency,
                                      isSelected:
                                          state.selectedParking?.id == e.id,
                                      onTap: () {
                                        context
                                            .read<ParkingDispatcherBloc>()
                                            .onParkingSelected(e);
                                      },
                                    ).toCustomMarker(e.location.toLatLngLib());
                                  }).toList() ??
                                  [],
                            ],
                          );
                        },
                      ),
                ),
                Container(
                  width: 478,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.tr.nearbySpots,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      const Expanded(child: ParkingsList()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.outline),
            color: context.colors.surface,
            boxShadow: kBottomBarShadow(context),
          ),
          padding: const EdgeInsets.all(16),
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
                    isDisabled: state.selectedParking == null,
                    onPressed: () {
                      showDialog(
                        context: context,
                        useSafeArea: false,
                        builder: (context) {
                          return const ConfirmParkingOrderDialog();
                        },
                      );
                    },
                    text: context.tr.actionContinue,
                    suffixIcon: BetterIcons.arrowRight02Outline,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
