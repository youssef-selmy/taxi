import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/blocs/park_spot_create.cubit.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/screens/pages/park_spot_create_details.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/screens/pages/park_spot_create_location_open_hours.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/screens/pages/park_spot_create_owner.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/screens/pages/park_spot_create_spaces_facilities.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class ParkSpotCreateScreen extends StatelessWidget {
  final String? parkSpotId;

  const ParkSpotCreateScreen({
    super.key,
    @PathParam("parkSpotId") this.parkSpotId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkSpotCreateBloc()..onStarted(),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding.copyWith(left: 0, right: 0, bottom: 16),
        child: BlocBuilder<ParkSpotCreateBloc, ParkSpotCreateState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsive(16, lg: 40),
                  ),
                  child: PageHeader(
                    title: isCreate
                        ? context.tr.createParkSpot
                        : context.tr.verifyParkSpot,
                    subtitle: isCreate
                        ? context.tr.enterParkSpotDetails
                        : context.tr.verifyParkSpotDetails,
                    showBackButton: true,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsive(16, lg: 40),
                  ),
                  child: AppHorizontalStepIndicator(
                    connectorStyle: ConnectorStyle.line,
                    style: StepIndicatorItemStyle.circular,
                    items: [
                      StepIndicatorItem(
                        label: context.tr.details,
                        value: 0,
                        description: context.tr.detailsSubtitle,
                      ),
                      StepIndicatorItem(
                        label: context.tr.locationAndDate,
                        value: 1,
                        description: context.tr.parkingSelectLocationSubtitle,
                      ),
                      StepIndicatorItem(
                        label: context.tr.facilitiesVehicleTypes,
                        value: 2,
                        description: context.tr.selectFacilitiesAndVehicleTypes,
                      ),
                      StepIndicatorItem(
                        label: context.tr.ownerInformation,
                        value: 3,
                        description: context.tr.enterOwnerInformation,
                      ),
                    ],
                    selectedStep: state.wizardStep,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: PageView(
                    controller: state.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      ParkSpotCreateDetails(),
                      ParkSpotCreateLocationOpenHours(),
                      ParkSpotCreateSpacesFacilities(),
                      ParkSpotCreateOwner(),
                    ],
                  ),
                ),
                const Divider(height: 16),
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsive(16, lg: 40),
                  ),
                  child: Row(
                    children: [
                      if (state.wizardStep != 0)
                        AppOutlinedButton(
                          onPressed: context
                              .read<ParkSpotCreateBloc>()
                              .onPreviousPage,
                          prefixIcon: BetterIcons.arrowLeft02Outline,
                          text: context.tr.back,
                        ),
                      const Spacer(),
                      if (state.wizardStep < 3)
                        AppFilledButton(
                          onPressed: context
                              .read<ParkSpotCreateBloc>()
                              .onNextPage,
                          text: context.tr.next,
                          suffixIcon: BetterIcons.arrowRight02Outline,
                        ),
                      if (state.wizardStep == 3)
                        AppFilledButton(
                          onPressed: context
                              .read<ParkSpotCreateBloc>()
                              .onSubmit,
                          text: context.tr.register,
                          suffixIcon: BetterIcons.arrowRight02Outline,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool get isCreate => parkSpotId == null;
}
