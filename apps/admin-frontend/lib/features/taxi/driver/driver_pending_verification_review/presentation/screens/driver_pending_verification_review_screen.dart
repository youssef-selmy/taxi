import 'package:admin_frontend/core/router/app_router.dart';
import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_details.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_documents.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_services.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/components/driver_pending_verification_review_bottom_action.dart';

@RoutePage()
class DriverPendingVerificationReviewScreen extends StatelessWidget {
  DriverPendingVerificationReviewScreen({super.key, required this.driverId});

  final String driverId;

  final GlobalKey<FormState> _formKeyDriverDetails = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriverPendingVerificationReviewBloc()..onStarted(driverId),
      child:
          BlocBuilder<
            DriverPendingVerificationReviewBloc,
            DriverPendingVerificationReviewState
          >(
            builder: (context, state) {
              return MultiBlocListener(
                listeners: [
                  BlocListener<
                    DriverPendingVerificationReviewBloc,
                    DriverPendingVerificationReviewState
                  >(
                    listenWhen: (previous, current) =>
                        previous.driverApproveState !=
                        current.driverApproveState,
                    listener: (context, state) {
                      switch (state.driverApproveState) {
                        case ApiResponseError():
                          context.showFailure(state.driverApproveState.error!);

                        case ApiResponseLoaded():
                          context.showSuccess("Driver approved successfully");
                          context.router.pop();
                        default:
                      }
                    },
                  ),
                  BlocListener<
                    DriverPendingVerificationReviewBloc,
                    DriverPendingVerificationReviewState
                  >(
                    listenWhen: (previous, current) =>
                        previous.driverRejectionState !=
                        current.driverRejectionState,
                    listener: (context, state) {
                      switch (state.driverRejectionState) {
                        case ApiResponseError():
                          context.showFailure(
                            state.driverRejectionState.error!,
                          );

                        case ApiResponseLoaded():
                          context.showSuccess("Driver rejected successfully");
                          context.router.pop();
                        default:
                      }
                    },
                  ),
                  BlocListener<
                    DriverPendingVerificationReviewBloc,
                    DriverPendingVerificationReviewState
                  >(
                    listenWhen: (previous, current) =>
                        previous.stepperCurrentIndex !=
                        current.stepperCurrentIndex,
                    listener: (context, state) {
                      final bloc = context
                          .read<DriverPendingVerificationReviewBloc>();
                      // Fetch data when navigating to specific steps
                      if (state.stepperCurrentIndex == 1) {
                        bloc.fetchDriverDocuments();
                      } else if (state.stepperCurrentIndex == 2) {
                        bloc.fetchServices();
                      }
                    },
                  ),
                ],
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: context.pagePadding,
                          color: context.colors.surface,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PageHeader(
                                title: context
                                    .tr
                                    .reviewPendingDriverVerificationInfo,
                                subtitle: context.tr.reviewDriverInformation,
                                showBackButton: true,
                                onBackButtonPressed: () {
                                  context.router.replace(
                                    DriverPendingVerificationListRoute(),
                                  );
                                },
                              ),
                              const SizedBox(height: 32),
                              AppHorizontalStepIndicator(
                                connectorStyle: ConnectorStyle.line,
                                style: StepIndicatorItemStyle.circular,
                                items: [
                                  StepIndicatorItem(
                                    label: context.tr.details,
                                    value: 0,
                                    description: context.tr.reviewInformation,
                                  ),
                                  StepIndicatorItem(
                                    label: context.tr.documents,
                                    value: 1,
                                    description:
                                        context.tr.reviewDriverDocuments,
                                  ),
                                  StepIndicatorItem(
                                    label: context.tr.servicePricing,
                                    value: 2,
                                    description:
                                        context.tr.selectServicePricingDriver,
                                  ),
                                ],
                                selectedStep: state.stepperCurrentIndex,
                              ),
                              const SizedBox(height: 32),
                              AnimatedSwitcher(
                                duration: kThemeAnimationDuration,
                                child: switch (state.stepperCurrentIndex) {
                                  0 => DriverPendingVerificationReviewDetails(
                                    formKey: _formKeyDriverDetails,
                                  ),
                                  1 =>
                                    const DriverPendingVerificationReviewDocuments(),
                                  2 =>
                                    const DriverPendingVerificationReviewServices(),
                                  int() => Text(context.tr.error),
                                },
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const AppDivider(height: 32),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        bottom: 16,
                        left: 16,
                      ),
                      child: DriverPendingVerificationRreviewBottomAction(
                        formKey: _formKeyDriverDetails,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
