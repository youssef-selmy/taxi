import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.mock.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/customer_profile.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/driver_location_card.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/service_bar.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/screens/dialogs/confirm_ride.dart';
import 'package:better_icons/better_icons.dart';

class SearchingForDriver extends StatelessWidget {
  const SearchingForDriver({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DispatcherTaxiBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: context.pagePaddingHorizontal,
          child: Row(
            children: [
              CustomerProfile(),
              SizedBox(width: 24),
              Expanded(child: ServiceBar()),
            ],
          ),
        ),
        SizedBox(height: context.isDesktop ? 32 : 24),
        if (context.isDesktop) ...[
          Padding(
            padding: context.pagePaddingHorizontal,
            child: Text(
              context.tr.selectDriver,
              style: context.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 16),
        ],
        Expanded(
          child: BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
            builder: (context, state) {
              return Container(
                margin: context.isDesktop
                    ? const EdgeInsets.symmetric(horizontal: 40)
                    : null,
                decoration: BoxDecoration(
                  border: context.isDesktop
                      ? Border.all(color: context.colors.outline)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    if (context.isDesktop)
                      Expanded(
                        child: AppGenericMap(
                          onControllerReady: (p0) {
                            bloc.onSearchForDriverMapControllerReady(p0);
                          },
                          padding: EdgeInsets.all(64),
                          initialLocation: state.locations.firstOrNull
                              ?.toGenericMapPlace(),
                          markers: [
                            ...state.locations.waypointsMarkers,
                            ...state.driverLocations.markers,
                          ],
                          circleMarkers: [
                            if (state.selectedDriverLocation != null)
                              state.selectedDriverLocation!.circleMarker(
                                context,
                              ),
                          ],
                        ),
                      ),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            context.tr.selectNearbyDriver,
                            style: context.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Skeletonizer(
                              enabled: state.networkState.isLoading,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemCount: state.networkState.isLoading
                                    ? 5
                                    : state.driverLocations.length,
                                itemBuilder: (context, index) {
                                  final driver =
                                      state.driverLocations.elementAtOrNull(
                                        index,
                                      ) ??
                                      mockDriverLocation1;
                                  return DriverLocationCard(
                                    driverLocation: driver,
                                    isSelected:
                                        driver.id ==
                                        state.selectedDriverLocation?.id,
                                    onTap: (driverLocation) => context
                                        .read<DispatcherTaxiBloc>()
                                        .selectDriverLocation(driverLocation),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 48),
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: context.colors.outline)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AppOutlinedButton(
                prefixIcon: BetterIcons.arrowLeft02Outline,
                onPressed: context.read<DispatcherTaxiBloc>().goBack,
                text: context.tr.back,
              ),
              const Spacer(),
              AppFilledButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (_) {
                      return BlocProvider.value(
                        value: context.read<DispatcherTaxiBloc>(),
                        child: const ConfirmRideDialog(assigned: false),
                      );
                    },
                  );
                },
                text: context.tr.dispatchToAllDrivers,
              ),
              const SizedBox(width: 8),
              BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
                builder: (context, state) {
                  return AppFilledButton(
                    isDisabled: state.selectedDriverLocation == null,
                    onPressed: () {
                      showDialog(
                        context: context,
                        useSafeArea: false,
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<DispatcherTaxiBloc>(),
                            child: const ConfirmRideDialog(assigned: true),
                          );
                        },
                      );
                    },
                    text: context.tr.assignToSelectedDriver,
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
