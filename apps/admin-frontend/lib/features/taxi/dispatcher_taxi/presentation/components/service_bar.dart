import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/service_option.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ServiceBar extends StatelessWidget {
  const ServiceBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
        builder: (context, state) {
          if (state.selectedService == null) {
            return const SizedBox();
          }
          final selectedService = state.selectedService!;
          return Column(
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: selectedService.media.address,
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedService.name,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurface,
                        ),
                      ),
                      if (selectedService.description != null)
                        Text(
                          selectedService.description!,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (state.rideOptions.isNotEmpty ||
                  state.waitingTime > 0 ||
                  state.isRoundTrip)
                const SizedBox(height: 8),
              Row(
                children: [
                  if (state.isRoundTrip) ...[
                    RideOptionView(
                      iconData: BetterIcons.informationCircleFilled,
                      title: context.tr.twoWayTrip,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (state.waitingTime > 0) ...[
                    RideOptionView(
                      iconData: BetterIcons.clock01Filled,
                      title:
                          "${state.waitingTime} ${context.tr.minWaitingTime}",
                    ),
                    const SizedBox(width: 8),
                  ],
                  ...state.rideOptions.map((option) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: RideOptionView(
                        iconData: option.icon.icon,
                        title: option.name,
                      ),
                    );
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class RideOptionView extends StatelessWidget {
  final IconData iconData;
  final String title;

  const RideOptionView({
    super.key,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.outline),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(iconData, color: context.colors.primary),
        ),
        const SizedBox(width: 8),
        Text(title, style: context.textTheme.labelMedium),
      ],
    );
  }
}
