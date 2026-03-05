import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/components/create_new_driver_bottom_actions.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/components/create_new_driver_details.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/components/create_new_driver_services.dart';

@RoutePage()
class CreateNewDriverScreen extends StatelessWidget {
  const CreateNewDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNewDriverBloc()..onStarted(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreateNewDriverBloc, CreateNewDriverState>(
            listenWhen: (previous, current) =>
                previous.createDriverState != current.createDriverState &&
                current.createDriverState.isError,
            listener: (context, state) {
              context.showFailure(state.createDriverState);
            },
          ),
          BlocListener<CreateNewDriverBloc, CreateNewDriverState>(
            listener: (context, state) {
              if (state.createDriverState.isLoaded) {
                context.showSuccess(context.tr.savedSuccessfully);
                context.router.replace(DriverListRoute());
              }
            },
          ),
        ],
        child: BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
          builder: (context, state) {
            return SafeArea(
              top: false,
              child: Container(
                color: context.colors.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: context.pagePaddingHorizontal,
                      child: PageHeader(
                        title: context.tr.addNewDriver,
                        subtitle: context.tr.inputDriverDetails,
                        showBackButton: true,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: context.pagePaddingHorizontal,
                      child: AppHorizontalStepIndicator(
                        connectorStyle: ConnectorStyle.line,
                        style: StepIndicatorItemStyle.circular,
                        items: [
                          StepIndicatorItem(
                            icon: BetterIcons.noteOutline,
                            label: context.tr.details,
                            value: 0,
                            description: context.tr.enterDetailsInformation,
                          ),
                          // StepIndicatorItem(
                          //   icon: BetterIcons.folder01Outline,
                          //   label: context.tr.documents,
                          //   value: 1,
                          //   description: context.tr.uploadDriversDocuments,
                          // ),
                          StepIndicatorItem(
                            icon: BetterIcons.creditCardOutline,
                            label: context.tr.servicePricing,
                            value: 2,
                            description: context.tr.selectDriversServices,
                          ),
                        ],
                        selectedStep: state.stepperCurrentIndex,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: context.pagePaddingHorizontal,
                        child: AnimatedSwitcher(
                          duration: kThemeAnimationDuration,
                          child: switch (state.stepperCurrentIndex) {
                            0 => CreateNewDriverDetails(),
                            // 1 => CreateNewDriverDocuments(),
                            1 => const CreateNewDriverServices(),
                            int() => Text(context.tr.error),
                          },
                        ),
                      ),
                    ),
                    const AppDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      child: CreateNewDriverBottomActions(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
