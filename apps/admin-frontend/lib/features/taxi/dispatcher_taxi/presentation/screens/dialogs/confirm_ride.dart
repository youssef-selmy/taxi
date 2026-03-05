import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/molecules/waypoints_view/waypoints_view.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/driver_profile/driver_profile_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/customer_profile.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/service_bar.dart';
import 'package:better_icons/better_icons.dart';

class ConfirmRideDialog extends StatelessWidget {
  final bool assigned;

  const ConfirmRideDialog({super.key, required this.assigned});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
      builder: (context, state) {
        return AppResponsiveDialog(
          icon: BetterIcons.alertCircleFilled,
          title: context.tr.confirmRide,
          subtitle: context.tr.pleaseConfirmRideProceed,
          primaryButton: AppFilledButton(
            isLoading: state.networkState.isLoading,
            text: context.tr.confirm,
            onPressed: () async {
              await context.read<DispatcherTaxiBloc>().bookRide(
                assignDriver: assigned,
              );
              if (context.mounted) {
                Navigator.of(context).pop();
              }
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomerProfile(),
              if (assigned) ...[
                const SizedBox(height: 16),
                DriverProfileSmall(
                  imageUrl: null,
                  fullName: state.selectedDriverLocation?.fullName,
                ),
              ],
              const SizedBox(height: 16),
              AppWaypointsView(waypoints: state.locations.toWaypointItemList()),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: context.colors.outline),
                    ),
                    child: Icon(
                      BetterIcons.clock01Filled,
                      color: context.colors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${context.tr.estimateTime}: ${state.fare?.duration != null ? ("${state.fare!.duration.toInt().toString()} min") : "-"}",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "${context.tr.serviceDetails}:",
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              const ServiceBar(),
              const SizedBox(height: 16),
              Text(
                description(context),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                footer(context),
                textAlign: TextAlign.center,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String description(BuildContext context) => assigned
      ? context.tr.forceAssignRideWarning
      : context.tr.rideConfirmationDriverNotification;

  String footer(BuildContext context) => assigned
      ? context.tr.forceAssignConfirmationFooter
      : context.tr.notifyDriversOnConfirmFooter;
}
