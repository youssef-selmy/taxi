import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';

class TaxiOverviewOnlineDrivers extends StatelessWidget {
  const TaxiOverviewOnlineDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaxiOverviewBloc>();
    return AppClickableCard(
      type: ClickableCardType.elevated,
      elevation: BetterShadow.shadow8,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.onlineDrivers,
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  context.tr.onlineDriversAndTheirCurrentLocation,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: 450,
            child: BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
              builder: (context, state) {
                final data = state.onlineDriversState.data;
                return Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.only(
                          bottomLeft: Radius.circular(8),
                        ),
                        child: AppGenericMap(
                          interactive: true,
                          padding: const EdgeInsets.all(64),
                          onControllerReady: (controller) async {
                            final center = Env.defaultLocation.latLng;
                            controller.moveCamera(center, 9);
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                            );
                            try {
                              final bounds = await controller
                                  .getViewportBounds();
                              bloc.add(
                                TaxiOverviewEvent.driversInViewPortFetch(
                                  bounds: Input$BoundsInput(
                                    northEast: bounds.northEast.toPointInput(),
                                    southWest: bounds.southWest.toPointInput(),
                                    zoom: 9,
                                  ),
                                ),
                              );
                            } catch (e) {
                              // Ignore viewport bounds errors (e.g., invalid longitude/latitude values)
                            }
                          },
                          onMapMoved: (event) {
                            if (event.type != MapMoveEventType.idle) {
                              return;
                            }
                            bloc.add(
                              TaxiOverviewEvent.driversInViewPortFetch(
                                bounds: Input$BoundsInput(
                                  northEast: event.bounds.northEast
                                      .toPointInput(),
                                  southWest: event.bounds.southWest
                                      .toPointInput(),
                                  zoom: event.zoom.round(),
                                ),
                              ),
                            );
                          },
                          markers: [
                            ...(state.onlineDriversClusters.data?.markers(
                                  context,
                                ) ??
                                []),
                            ...(state.singleOnlineDrivers.data?.markers ?? []),
                          ],
                        ),
                      ),
                    ),
                    if (context.isDesktop)
                      SizedBox(
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: context.colors.surfaceVariantLow,
                                border: Border(
                                  bottom: BorderSide(
                                    color: context.colors.outline,
                                  ),
                                ),
                              ),
                              child: Text(
                                context.tr.onlineDrivers,
                                style: context.textTheme.labelLarge,
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                itemCount:
                                    data?.getDriversLocationWithData.length ??
                                    0,
                                separatorBuilder: (context, index) =>
                                    const AppDivider(height: 36),
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: data?.getDriversLocationWithData[index]
                                      .listView(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
