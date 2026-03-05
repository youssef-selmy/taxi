import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_review/presentation/blocs/driver_pending_verification_review.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverPendingVerificationReviewDetails extends StatelessWidget {
  const DriverPendingVerificationReviewDetails({
    super.key,
    required this.formKey,
  });
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPendingVerificationReviewBloc>();
    return Form(
      key: formKey,
      child:
          BlocBuilder<
            DriverPendingVerificationReviewBloc,
            DriverPendingVerificationReviewState
          >(
            builder: (context, state) {
              final driver = state.driverReviewState.data;

              return AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: switch (state.driverReviewState) {
                  ApiResponseInitial() => const SizedBox(),
                  ApiResponseLoading() => Center(
                    child: const CupertinoActivityIndicator(),
                  ),
                  ApiResponseLoaded() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LargeHeader(
                        title: context.tr.reviewDriverDetailsInformation,
                      ),
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 24),
                      Skeletonizer(
                        enabled: state.driverReviewState.isLoading,
                        enableSwitchAnimation: true,
                        child: Column(
                          crossAxisAlignment: context.responsive(
                            CrossAxisAlignment.center,
                            lg: CrossAxisAlignment.start,
                          ),
                          children: <Widget>[
                            UploadFieldSmall(
                              title: context.tr.profilePicture,
                              onChanged: bloc.onProfileImageChange,
                              initialValue: state.driverReview?.media,
                            ),
                            LayoutGrid(
                              columnSizes: context.responsive(
                                [1.fr],
                                lg: [1.fr, 1.fr],
                              ),
                              rowGap: 16,
                              columnGap: 16,
                              rowSizes: List.generate(
                                context.responsive(17, lg: 9),
                                (index) => auto,
                              ),
                              children: <Widget>[
                                AppTextField(
                                  initialValue: state.driverReview?.firstName,
                                  label: context.tr.firstName,
                                  validator: context.validateName,
                                  hint: context.tr.enterFirstName,
                                  onChanged: bloc.onFirstNameChange,
                                ),
                                AppTextField(
                                  initialValue: state.driverReview?.lastName,
                                  label: context.tr.lastName,
                                  validator: context.validateName,
                                  hint: context.tr.enterLastName,
                                  onChanged: bloc.onLastNameChange,
                                ),
                                AppTextField(
                                  initialValue:
                                      state.driverReview?.mobileNumber,
                                  label: context.tr.phone,
                                  hint: context.tr.enterPhone,
                                  onChanged: bloc.onPhoneChange,
                                ),
                                AppTextField(
                                  initialValue: state.driverReview?.email,
                                  label: context.tr.email,
                                  hint: context.tr.enterEmail,
                                  onChanged: bloc.onEmailChange,
                                ),
                                AppDropdownField<Enum$Gender>.single(
                                  initialValue: state.driverReview?.gender,
                                  items: Enum$Gender.values
                                      .where((e) => e != Enum$Gender.$unknown)
                                      .map(
                                        (e) => AppDropdownItem(
                                          title: e.name,
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  label: context.tr.gender,
                                  hint: context.tr.selectGender,
                                  onChanged: bloc.onGenderChange,
                                ),
                                AppDropdownField<Fragment$fleetListItem>.single(
                                  initialValue: driver?.fleets.nodes
                                      .where(
                                        (e) =>
                                            e.id == state.driverReview?.fleetId,
                                      )
                                      .firstOrNull,
                                  items:
                                      state.driverReviewState.data?.fleets.nodes
                                          .map(
                                            (e) => AppDropdownItem(
                                              title: e.name,
                                              value: e,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                  label: context.tr.fleets,
                                  hint: context.tr.selectFleet,
                                  onChanged: bloc.onFleetChange,
                                ),
                                AppDropdownField<Fragment$vehicleModel>.single(
                                  initialValue: driver?.carModels.nodes
                                      .where(
                                        (e) =>
                                            e.id == state.driverReview?.carId,
                                      )
                                      .firstOrNull,
                                  items:
                                      state
                                          .driverReviewState
                                          .data
                                          ?.carModels
                                          .nodes
                                          .map(
                                            (e) => AppDropdownItem(
                                              title: e.name,
                                              value: e,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                  label: context.tr.carModel,
                                  hint: context.tr.selectCarModel,
                                  onChanged: bloc.onCarModelChange,
                                ),
                                AppDropdownField<Fragment$vehicleColor>.single(
                                  initialValue: driver?.carColors.nodes
                                      .where(
                                        (e) =>
                                            e.id ==
                                            state.driverReview?.carColorId,
                                      )
                                      .firstOrNull,
                                  items:
                                      state
                                          .driverReviewState
                                          .data
                                          ?.carColors
                                          .nodes
                                          .map(
                                            (e) => AppDropdownItem(
                                              title: e.name,
                                              value: e,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                  label: context.tr.carColor,
                                  hint: context.tr.selectCarColor,
                                  onChanged: bloc.onCarColorChange,
                                ),
                                AppNumberField.integer(
                                  initialValue:
                                      state.driverReview?.carProductionYear,
                                  title: context.tr.carProductionYear,
                                  validator: FormBuilderValidators.required(),
                                  hint: context.tr.enterCarProductionYear,
                                  onChanged: bloc.onCarProductionYearChange,
                                ),
                                AppTextField(
                                  initialValue: state.driverReview?.carPlate,
                                  label: context.tr.carPlateNumber,
                                  validator: FormBuilderValidators.required(),
                                  hint: context.tr.enterCarPlateNumber,
                                  onChanged: bloc.onCarPlateNumberChange,
                                ),
                                // AppTextField(
                                //   initialValue:
                                //       state.driverReview?.accountNumber,
                                //   label: context.tr.accountNumber,
                                //   validator: FormBuilderValidators.required(),
                                //   hint: context.tr.enterAccountNumber,
                                //   onChanged: bloc.onAccountNumberChange,
                                // ),
                                // AppTextField(
                                //   initialValue: state.driverReview?.bankName,
                                //   label: context.tr.bankName,
                                //   validator: FormBuilderValidators.required(),
                                //   hint: context.tr.enterBankName,
                                //   onChanged: bloc.onBankNameChange,
                                // ),
                                // AppTextField(
                                //   initialValue:
                                //       state.driverReview?.bankRoutingNumber,
                                //   label: context.tr.bankRoutingNumber,
                                //   validator: FormBuilderValidators.required(),
                                //   hint: context.tr.enterBankRoutingNumber,
                                //   onChanged: bloc.onBankRoutingNumberChange,
                                // ),
                                // AppTextField(
                                //   initialValue: state.driverReview?.bankSwift,
                                //   label: context.tr.bankSwift,
                                //   validator: FormBuilderValidators.required(),
                                //   hint: context.tr.enterBankSwift,
                                //   onChanged: bloc.onBankSwiftChange,
                                // ),
                                AppTextField(
                                  initialValue: state.driverReview?.address,
                                  label: context.tr.address,
                                  hint: context.tr.enterAddress,
                                  onChanged: bloc.onAddressChange,
                                ).withGridPlacement(
                                  columnSpan: context.responsive(1, lg: 2),
                                ),
                              ],
                            ),
                            const SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ApiResponseError(:final message) => Text(message),
                },
              );
            },
          ),
    );
  }
}
