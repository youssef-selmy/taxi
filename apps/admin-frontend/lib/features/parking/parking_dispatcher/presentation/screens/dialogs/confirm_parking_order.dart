import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/blocs/parking_dispatcher.cubit.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/components/customer_profile.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/components/date_and_time_view.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/components/parking_list_item.dart';
import 'package:better_icons/better_icons.dart';

class ConfirmParkingOrderDialog extends StatelessWidget {
  const ConfirmParkingOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingDispatcherBloc(),
      child: AppResponsiveDialog(
        icon: BetterIcons.informationCircleFilled,
        title: context.tr.confirmParkingOrder,
        subtitle: context.tr.reviewParkingOrderDetailsPrompt,
        maxWidth: 648,
        secondaryButton: AppOutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          text: context.tr.cancel,
        ),
        primaryButton:
            BlocConsumer<ParkingDispatcherBloc, ParkingDispatcherState>(
              listener: (context, state) {
                if (state.isSuccessful) {
                  Navigator.of(context).pop();
                  context.read<ParkingDispatcherBloc>().reset();
                }
              },
              builder: (context, state) {
                return AppFilledButton(
                  isLoading: state.networkState.isLoading,
                  onPressed: context
                      .read<ParkingDispatcherBloc>()
                      .confirmParkingOrder,
                  text: context.tr.confirmReservation,
                );
              },
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomerProfile(),
            const SizedBox(height: 16),
            const DateAndTimeView(),
            const SizedBox(height: 16),
            Text(
              context.tr.spotDetails,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
              builder: (context, state) {
                return ParkingListItem(
                  item: state.selectedParking ?? mockParkSpotDetail,
                  onSelected: null,
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              context.tr.confirmReservationResponsibilityWarning,
              textAlign: TextAlign.justify,
              style: context.textTheme.bodyMedium?.variant(context),
            ),
            const SizedBox(height: 24),
            Text(
              context.tr.confirmReservationSendsRequestInfo,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        ),
      ),
    );
  }
}
