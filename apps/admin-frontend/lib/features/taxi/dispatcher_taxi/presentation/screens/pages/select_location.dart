import 'package:admin_frontend/core/enums/address_type.enum.dart';
import 'package:better_design_system/atoms/map_pin/rod_marker.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:better_design_system/molecules/waypoints_view/waypoints_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_frontend/core/components/address/address_list_item.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/components/upsert_location/upsert_location.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/customer_profile.dart';
import 'package:better_icons/better_icons.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DispatcherTaxiBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: context.pagePaddingHorizontal,
          child: CustomerProfile(),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: context.pagePaddingHorizontal,
          child: Text(
            context.tr.selectLocations,
            style: context.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: context.pagePaddingHorizontal,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: const BoxConstraints(maxHeight: 150),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child:
                            BlocBuilder<
                              DispatcherTaxiBloc,
                              DispatcherTaxiState
                            >(
                              builder: (context, state) {
                                return AppGenericMap(
                                  mode: MapViewMode.picker,
                                  interactive: true,
                                  enableAddressResolve: true,
                                  padding: EdgeInsets.all(32),

                                  onPlaceSelected: (place) {
                                    bloc.onMapMoved(
                                      MapMoveEventType.addressResolved,
                                      place,
                                    );
                                  },
                                  onControllerReady: (p0) {
                                    bloc.onSelectLocationMapControllerReady(p0);
                                  },
                                  onMapMoved: (event) =>
                                      bloc.onMapMoved(event.type, event.place),
                                  centerMarkerBuilder:
                                      (context, key, address) =>
                                          AppRodPin.centerMarkerDestination(
                                            key: key,
                                          ),
                                  markers: [
                                    ...state.locations.waypointsMarkers,
                                    ...state.customerAddresses.map(
                                      (e) => AppRodMarker.marker(
                                        id: e.id,
                                        position: e.location.toLatLngLib(),
                                        iconData: e.type.icon,
                                        title: e.title,
                                        subtitle: e.details,
                                      ),
                                    ),
                                  ],
                                  initialLocation: state.mapCenter
                                      ?.toGenericMapPlace(),
                                  hasSearchBar: true,
                                );
                              },
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4),
                        width: double.infinity,
                        child:
                            BlocBuilder<
                              DispatcherTaxiBloc,
                              DispatcherTaxiState
                            >(
                              builder: (context, state) {
                                return AppFilledButton(
                                  text: context.tr.addLocation,
                                  isDisabled:
                                      state.mapCenter == null ||
                                      state.mapCenter!.address.isEmpty,
                                  onPressed: bloc.addLocation,
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  padding: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(0),
                                child:
                                    BlocBuilder<
                                      DispatcherTaxiBloc,
                                      DispatcherTaxiState
                                    >(
                                      builder: (context, state) {
                                        return AppWaypointsView(
                                          waypoints: state.locations
                                              .toWaypointItemList(),
                                        );
                                      },
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child:
                                  BlocBuilder<
                                    DispatcherTaxiBloc,
                                    DispatcherTaxiState
                                  >(
                                    builder: (context, state) {
                                      return AppOutlinedButton(
                                        color: SemanticColor.error,
                                        isDisabled: state.locations.isEmpty,
                                        onPressed: () {
                                          context
                                              .read<DispatcherTaxiBloc>()
                                              .removeLastLocation();
                                        },
                                        text: context.tr.removeLastLocation,
                                      );
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    context.tr.savedAddresses,
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ),
                                AppTextButton(
                                  text: context.tr.addNewAddress,
                                  size: ButtonSize.small,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      useSafeArea: false,
                                      builder: (context) =>
                                          const UpsertLocationDialog(),
                                    );
                                  },
                                  prefixIcon: BetterIcons.addCircleOutline,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child:
                                  BlocBuilder<
                                    DispatcherTaxiBloc,
                                    DispatcherTaxiState
                                  >(
                                    builder: (context, state) {
                                      return ListView.builder(
                                        itemBuilder: (context, index) {
                                          return AddressListItem(
                                            address:
                                                state.customerAddresses[index],
                                            onSelected: context
                                                .read<DispatcherTaxiBloc>()
                                                .onAddressSelected,
                                          );
                                        },
                                        itemCount:
                                            state.customerAddresses.length,
                                      );
                                    },
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 48),
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: context.colors.outline)),
          ),
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                AppOutlinedButton(
                  prefixIcon: BetterIcons.arrowLeft02Outline,
                  onPressed: context.read<DispatcherTaxiBloc>().goBack,
                  text: context.tr.back,
                ),
                const Spacer(),
                BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
                  builder: (context, state) {
                    return AppFilledButton(
                      isDisabled: state.locations.length < 2,
                      onPressed: context
                          .read<DispatcherTaxiBloc>()
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
